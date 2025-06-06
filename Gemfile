# frozen_string_literal: true

source 'https://rubygems.org'

# Gems default
gem 'rails', '~> 8.0.2'
gem 'propshaft'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'importmap-rails'
gem 'jsbundling-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'cssbundling-rails'
gem 'jbuilder'
gem 'tzinfo-data', platforms: %i[ windows jruby ]
gem 'solid_cache'
gem 'solid_queue'
gem 'solid_cable'

gem 'bootsnap', require: false
gem 'kamal', require: false
gem 'thruster', require: false

# HTTP client for API calls
gem 'rest-client'
gem 'aws-sdk-s3', '~> 1.131.0', require: false
gem 'aws-sdk-secretsmanager', '~> 1.67', require: false

# Debugging
gem 'pry'
gem 'pry-rails'
gem 'pry-byebug'

# Type checking

# Pagination
gem 'kaminari'

group :development, :test do
  # Gems default
  gem 'debug', platforms: %i[ mri windows ], require: 'debug/prelude'
  gem 'brakeman', require: false
  gem 'rubocop-rails-omakase', require: false

  # Gems added
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'sorbet'
  gem 'tapioca', require: false
  gem 'sorbet-runtime'
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
