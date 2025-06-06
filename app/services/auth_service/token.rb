# frozen_string_literal: true

require 'aws-sdk-secretsmanager'

module AuthService
  class Token
    def initialize
      @sm_client = AuthService::Client.new(
        'secret_id',
        'role_arn',
        'role_name'
      ).call
    end

    def call
      @headers ||= if Rails.env.production?
        { auth_token: sm_token, buk_origin_service: @secret_id, content_type: 'application/json' }
      else
        {
          'BUK-ORIGIN-SERVICE' => 'portal_de_empleos_buk_web_app',
          'AUTH-TOKEN' => 'token'
        }
      end
    end

    private

    def encryptor
      @encryptor ||= ActiveSupport::MessageEncryptor.new(ENV['SECRET_KEY_BASE'][0..31])
    end

    def sm_token
      secret_string = Rails.cache.fetch('cached_sm_token', race_condition_ttl: 10.seconds, expires_in: 30.minutes) do
        encryptor.encrypt_and_sign @sm_client.get_secret_value(secret_id: @secret_id).secret_string
      end
      encryptor.decrypt_and_verify(secret_string)
    rescue ActiveSupport::MessageEncryptor::InvalidMessage => _e
      Rails.cache.delete('cached_sm_token')
      secret_string = Rails.cache.fetch('cached_sm_token', race_condition_ttl: 10.seconds, expires_in: 30.minutes) do
        encryptor.encrypt_and_sign @sm_client.get_secret_value(secret_id: @secret_id).secret_string
      end
      encryptor.decrypt_and_verify(secret_string)
    end
  end
end
