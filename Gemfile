# frozen_string_literal: true

source 'https://rubygems.org'

# Gems default
gem 'rails', '~> 8.0.1'
gem 'propshaft'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'
gem 'tzinfo-data', platforms: %i[ windows jruby ]
gem 'solid_cache'
gem 'solid_queue'
gem 'solid_cable'
gem 'bootsnap', require: false
gem 'kamal', require: false
gem 'thruster', require: false

# Gems added
gem 'tailwindcss-rails'
gem 'kaminari'

group :development, :test do
  gem 'debug', platforms: %i[ mri windows ], require: 'debug/prelude'
  # Gems default
  gem 'brakeman', require: false
  gem 'rubocop-rails-omakase', require: false

  # Gems added
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  # Gems default
  gem 'web-console'

  # Gems added
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
end

group :test do
  # Gems default
  gem 'capybara'
  gem 'selenium-webdriver'
end
