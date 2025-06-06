# frozen_string_literal: true

module Webapp
  class JobOfferSyncService
    def initialize(message)
      @message = message
      @action = message[:action]
      @model = message[:model]
      @record_id = message[:record_id]
      @tenant = message[:tenant]
      @origin = message[:origin]
      @timestamp = message[:timestamp]
    end

    def call
      Rails.logger.info("Processing #{action} for #{model} #{record_id} from tenant #{tenant}")

      case action
      when :create, :update
        sync_job_offer
      when :destroy
        remove_job_offer
      else
        Rails.logger.warn("Unknown action: #{action}")
      end
    rescue StandardError => e
      Rails.logger.error("Error processing message: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      raise e
    end

    private

    attr_reader :message, :action, :model, :record_id, :tenant, :origin, :timestamp

    def sync_job_offer
      Rails.logger.info("Syncing job offer #{record_id} from #{tenant}")

      response = FetchJobOffersService.new(url: tenant, id: record_id).call
      process_response(response)
    end

    def remove_job_offer
      Rails.logger.info("Removing job offer #{record_id} from #{tenant}")

      job_offer_reference = JobOfferReference.find_by(
        external_id: record_id,
        tenant: tenant
      )

      if job_offer_reference&.job_offer
        job_offer_reference.job_offer.update!(status: :closed)
        Rails.logger.info("Job offer #{job_offer_reference.job_offer.id} marked as closed")
      else
        Rails.logger.warn("Job offer reference not found for external_id: #{record_id}, tenant: #{tenant}")
      end
    end

    def deactivate_job_offer(external_id, tenant)
      job_offer_reference = JobOfferReference.find_by(
        external_id: external_id,
        tenant: tenant
      )

      job_offer_reference&.job_offer&.update!(status: :closed)
    end

    def process_response(response)
      Rails.logger.info("[JobOfferSyncService] Processing response for job offer #{record_id}")

      seleccion_data = response['seleccion']
      empresa_data = response['empresa']

      # 1. Crear o actualizar Company
      company = find_or_create_company(empresa_data)
      Rails.logger.info("[JobOfferSyncService] Company processed: #{company.id}")

      # 2. Crear o actualizar JobOfferReference
      job_offer_reference = JobOfferReference.find_or_create_by!(
        external_id: seleccion_data['id'],
        external_url: tenant
      ) do |ref|
        ref.external_url = build_external_url(seleccion_data['id'])
        ref.source = :buk_webapp
        ref.public_token = seleccion_data['public_token']
      end
      Rails.logger.info("[JobOfferSyncService] JobOfferReference processed: #{job_offer_reference.id}")

      # 3. Crear o actualizar JobOffer
      job_offer = find_or_create_job_offer(seleccion_data, company, job_offer_reference)
      Rails.logger.info("[JobOfferSyncService] JobOffer processed: #{job_offer.id}")

      {
        company: company,
        job_offer_reference: job_offer_reference,
        job_offer: job_offer
      }
    rescue StandardError => e
      Rails.logger.error("[JobOfferSyncService] Error processing response: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      raise e
    end

    def find_or_create_company(empresa_data)
      identifier = extract_identifier(empresa_data['rut'])
      identifier_type = determine_identifier_type(empresa_data['type'])

      Company.find_or_create_by!(
        identifier_value: identifier,
        identifier_type: identifier_type
      ) do |company|
        company.name = empresa_data['nombre']
        company.fantasy_name = empresa_data['fantasy_name']
        company.image_url = empresa_data['image_url']
      end
    end

    def find_or_create_job_offer_reference(external_id)
      JobOfferReference.find_or_create_by!(
        external_id: external_id,
        external_url: tenant
      ) do |ref|
        ref.external_url = build_external_url(external_id)
        ref.source = :buk_webapp
      end
    end

    def find_or_create_job_offer(seleccion_data, company, job_offer_reference)
      job_offer = job_offer_reference.job_offer

      if job_offer
        # Actualizar job offer existente
        job_offer.update!(job_offer_attributes(seleccion_data))
        Rails.logger.info("[JobOfferSyncService] Updated existing job offer #{job_offer.id}")
      else
        # Crear nuevo job offer
        job_offer = JobOffer.create!(
          job_offer_attributes(seleccion_data).merge(
            company: company,
            job_offer_reference: job_offer_reference
          )
        )
        Rails.logger.info("[JobOfferSyncService] Created new job offer #{job_offer.id}")
      end

      job_offer
    end

    def job_offer_attributes(seleccion_data)
      {
        name: seleccion_data['public_name'] || seleccion_data['name'],
        description: seleccion_data['description'],
        requirements: seleccion_data['requirements'],
        status: map_status(seleccion_data['status']),
        job_department: seleccion_data['job_department'],
        job_division: seleccion_data['job_division'],
        job_area: seleccion_data['job_area'],
        job_type: map_job_type(seleccion_data['full_time']),
        job_schedule: seleccion_data['job_schedule'],
        vacancies_count: seleccion_data['vacancies'],
        location: seleccion_data['location'],
        show_location: seleccion_data['show_location_in_applications_portal'],
        published_at: parse_datetime(seleccion_data['start_date']),
        show_published_at: seleccion_data['show_publish_date_in_applications_portal'],
        show_salary_range: seleccion_data['show_salary_range_in_applications_portal'],
        min_salary: seleccion_data['salary_min'],
        max_salary: seleccion_data['salary_max'],
        use_fantasy_name: seleccion_data['use_fantasy_name'],
        visible: seleccion_data['published_in_applications_portal']
      }
    end

    def map_status(webapp_status)
      case webapp_status
      when 'iniciado'
        :published
      when 'cerrado'
        :closed
      else
        :draft
      end
    end

    def map_job_type(full_time)
      full_time ? 'Full Time' : 'Part Time'
    end

    def extract_identifier(rut_string)
      # Remover puntos y guiones del RUT/identificador
      rut_string&.gsub(/[.-]/, '')
    end

    def determine_identifier_type(type_string)
      case type_string
      when /Chile/
        :rut
      when /Peru/
        :ruc
      when /Brasil/
        :cnpj
      when /Colombia/
        :nit
      when /Mexico/
        :rfc
      else
        :rut # default
      end
    end

    def parse_datetime(datetime_string)
      return nil if datetime_string.blank?

      Time.parse(datetime_string)
    rescue ArgumentError => e
      Rails.logger.warn("[JobOfferSyncService] Failed to parse datetime: #{datetime_string} - #{e.message}")
      nil
    end

    def build_external_url(external_id)
      "http://localhost:3000/#{tenant}/recruiting/selections/#{external_id}"
    end
  end
end
