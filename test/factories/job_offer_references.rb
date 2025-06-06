# frozen_string_literal: true

FactoryBot.define do
  factory :job_offer_reference do
    source { 'buk_webapp' }
    external_id { Faker::Number.number(digits: 8) }
    external_url { Faker::Internet.url }
    public_token { Faker::Number.number(digits: 8) }
  end
end
