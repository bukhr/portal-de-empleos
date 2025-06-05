# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    identifier_value { Faker::ChileRut.full_rut }
    identifier_type { :rut }
    name { Faker::Company.name }
    fantasy_name { name + ' de Fantasia '}
    image_url { "https://picsum.photos/id/#{rand(1..1000)}/200/300" }
    background_color { Faker::Color.hex_color }
  end
end
