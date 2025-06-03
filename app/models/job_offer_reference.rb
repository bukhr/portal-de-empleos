class JobOfferReference < ApplicationRecord
  belongs_to :job_offer

  enum :source, [ :buk_webapp ]
end
