# frozen_string_literal: true

class JobOffer < ApplicationRecord
  belongs_to :company
  belongs_to :job_offer_reference

  delegate :external_url, to: :job_offer_reference

  enum :status, [ :draft, :published, :closed ]
end
