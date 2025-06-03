class JobOffer < ApplicationRecord
  has_one :job_offer_reference, dependent: :destroy

  enum :status, [ :draft, :published, :closed ]
end
