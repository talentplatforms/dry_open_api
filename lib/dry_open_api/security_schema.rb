require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#security-scheme-object
  class SecuritySchema
    prepend EquatableAsContent
    extend Dry::Initializer

    option :type, proc(&:to_s)
    option :name, proc(&:to_s)
    option :in, proc(&:to_s)
    option :scheme, proc(&:to_s)
    option :flows
    option :open_id_connect_url, proc(&:to_s)
    option :bearer_format, proc(&:to_s), default: proc { nil }
    option :description, proc(&:to_s), default: proc { nil }

    # rubocop:disable Metrics/MethodLength
    def self.load(hash)
      return unless hash

      new(
        type: hash['type'],
        description: hash['description'],
        name: hash['name'],
        in: hash['in'],
        scheme: hash['scheme'],
        bearer_format: hash['bearerFormat'],
        flows: OAuthFlows.load(hash['flows']),
        open_id_connect_url: hash['openIdConnectUrl']
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
