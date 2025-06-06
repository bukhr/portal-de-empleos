# frozen_string_literal: true

require 'aws-sdk-secretsmanager'

module AuthService
  class Client
    def initialize(origin_service_id, role_arn, role_name)
      @region = origin_service_id.split(':')[3]
      @role_arn = role_arn
      @role_name = role_name
    end

    def call
      if Rails.env.development?
        Aws::SecretsManager::Client.new(stub_responses: true)
      else
        creds = Aws::AssumeRoleCredentials.new(
          role_arn: @role_arn,
          role_session_name: @role_name,
          region: @region
        )

        Aws::SecretsManager::Client.new(region: @region, credentials: creds)
      end
    end
  end
end
