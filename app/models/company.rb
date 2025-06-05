# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :job_offers, dependent: :destroy

  enum :identifier_type, [
    :rut, # Chile
    :ruc, # Peru
    :cnpj, # Brasil
    :nit, # Colombia
    :rfc # Mexico
  ]

  def country
    case identifier_type
    when 'rut'
      'Chile'
    when 'ruc'
      'Peru'
    when 'cnpj'
      'Brasil'
    when 'nit'
      'Colombia'
    when 'rfc'
      'Mexico'
    end
  end
end
