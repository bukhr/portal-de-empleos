# frozen_string_literal: true

class JobOffersController < ApplicationController
  def index
    @job_offers = JobOffer.where(visible: true).order(name: :asc)
    params[:layout] ||= 'v1'

    if params[:search].present?
      @job_offers = @job_offers.where('name ILIKE ?', "%#{params[:search]}%")
    end

    if params[:company_id].present?
      @job_offers = @job_offers.where(company_id: params[:company_id])
    end

    @job_offers = @job_offers.page(params[:page]).per(25)
  end

  def show
    @job_offer = JobOffer.find(params[:id])
  end
end
