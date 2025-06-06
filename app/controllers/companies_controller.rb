# frozen_string_literal: true

class CompaniesController < ApplicationController
  def index
    @companies = Company.order(updated_at: :desc)
  end
end
