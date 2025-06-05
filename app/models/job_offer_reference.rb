# frozen_string_literal: true

class JobOfferReference < ApplicationRecord
  has_one :job_offer, dependent: :destroy

  enum :source, [ :buk_webapp ]
end
