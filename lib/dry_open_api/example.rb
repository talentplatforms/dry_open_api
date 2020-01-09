require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#exampleObject
  class Example
    extend Dry::Initializer

    option :value, default: proc { nil }
    option :summary, proc(&:to_s), default: proc { nil }
    option :description, proc(&:to_s), default: proc { nil }
    option :external_value, proc(&:to_s), default: proc { nil }

    def self.load(hash)
      return unless hash

      new(
        summary: hash['summary'],
        description: hash['description'],
        value: hash['value'],
        external_value: hash['externalValue']
      )
    end
  end
end
