class Company < ApplicationRecord
  has_many :job_offers, dependent: :destroy

  enum :identifier_type, [
    :rut, # Chile
    :ruc, # Peru
    :cnpj, # Brasil
    :nit, # Colombia
    :rfc # Mexico
  ]
end
