require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#server-object
  class Server
    prepend EquatableAsContent
    extend Dry::Initializer

    option :url, proc(&:to_s)
    option :description, proc(&:to_s), default: proc { nil }
    option :variables, default: proc { nil }

    def self.load(hash)
      new(
        url: hash['url'],
        description: hash['description'],
        variables: hash['variables']&.map { |h| ServerVariable.load(h) }
      )
    end
  end
end
