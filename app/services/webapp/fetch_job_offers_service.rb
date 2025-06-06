# frozen_string_literal: true

module Webapp
  class FetchJobOffersService
    def initialize(url:, id:)
      @url = url
      @seleccion_id = id
    end

    def call
      Rails.logger.info('Extrayendo job offer desde Buk Webapp')
      url = "#{@url}/internal_api/v1/seleccions/#{@seleccion_id}?tenant=demo4"

      begin
        response = RestClient::Request.execute(
          method: :get,
          url: url,
          headers: headers
        )

        response = JSON.parse(response.body)
        puts "response: #{response}"
        response
      rescue RestClient::ExceptionWithResponse => e
        Rails.logger.error("[Webapp::JobOffer] - Error al extraer job offer: #{e.message}")
        raise e
      end
    end

    def headers
      @headers ||= AuthService::Token.new.call
    end
  end
end
