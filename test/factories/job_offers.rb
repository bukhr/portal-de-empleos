# frozen_string_literal: true

FactoryBot.define do
  factory :job_offer do
    company_id { create(:company).id }
    job_offer_reference_id { create(:job_offer_reference).id }
    status { :published }
    name { Faker::Job.title }
    description { Faker::Lorem.paragraph }
    requirements { Faker::Lorem.paragraph }
    job_area { Faker::Job.field }
    job_department { Faker::Job.field }
    job_division { Faker::Job.field }
    job_type { [ 'Full Time', 'Part Time' ].sample }
    job_schedule { [ 45, 30, 20, 15, 10, 5 ].sample }
    vacancies_count { Faker::Number.between(from: 1, to: 10) }
    show_location { true }
    location { Faker::Address.city }
    show_published_at { true }
    published_at { Faker::Time.between(from: 1.day.ago, to: 1.day.ago) }
    show_salary_range { true }
    min_salary { Faker::Number.between(from: 1000, to: 10000) }
    max_salary { Faker::Number.between(from: 10000, to: 100000) }
    use_fantasy_name { false }
    visible { true }
  end
end
