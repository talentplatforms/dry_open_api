require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#oauthFlowObject
  class OAuthFlow
    prepend EquatableAsContent
    extend Dry::Initializer

    option :authorization_url, proc(&:to_s)
    option :scopes, proc(&:to_s)
    option :token_url, proc(&:to_s)
    option :refresh_url, proc(&:to_s), default: proc { nil }

    def self.load(hash)
      return unless hash

      new(
        authorization_url: hash['authorizationUrl'],
        token_url: hash['tokenUrl'],
        refresh_url: hash['refreshUrl'],
        scopes: hash['scopes']
      )
    end
  end
end
