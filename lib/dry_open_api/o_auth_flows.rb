require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#oauth-flows-object
  class OAuthFlows
    prepend EquatableAsContent
    extend Dry::Initializer

    attr_accessor :implicit, :password, :client_credentials, :authorization_code

    option :implicit, proc(&:to_s), default: proc { nil }
    option :password, proc(&:to_s), default: proc { nil }
    option :client_credentials, proc(&:to_s), default: proc { nil }
    option :authorization_code, proc(&:to_s), default: proc { nil }

    def self.load(hash)
      return unless hash

      new(
        implicit: OAuthFlow.load(hash['implicit']),
        password: OAuthFlow.load(hash['password']),
        client_credentials: OAuthFlow.load(hash['clientCredentials']),
        authorization_code: OAuthFlow.load(hash['authorizationCode']),
      )
    end
  end
end
