# frozen_string_literal: true

class JobOffersController < ApplicationController
  def index
    params[:page] ||= 1
    @job_offers = JobOffer.where(visible: true)
    @job_offers = @job_offers.page(params[:page]).per(25)
  end

  def show
    @job_offer = JobOffer.find(params[:id])
  end
end
