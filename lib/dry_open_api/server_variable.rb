require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#server-variable-object
  class ServerVariable
    prepend EquatableAsContent
    extend Dry::Initializer

    option :default
    option :enum, default: proc { nil }
    option :description, proc(&:to_s), default: proc { nil }

    def self.load(hash)
      new(
        enum: hash['enum'],
        default: hash['default'],
        description: hash['description']
      )
    end
  end
end
