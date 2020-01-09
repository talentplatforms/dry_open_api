require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#xml-object
  class Xml
    extend Dry::Initializer

    option :name, proc(&:to_s), default: proc { nil }
    option :namespace, proc(&:to_s), default: proc { nil }
    option :prefix, proc(&:to_s), default: proc { nil }
    option :attribute, default: proc { false }
    option :wrapped, default: proc { false }

    def self.load(hash)
      return unless hash

      new(
        name: hash['name'],
        namespace: hash['namespace'],
        prefix: hash['prefix'],
        attribute: hash['attribute'],
        wrapped: hash['wrapped']
      )
    end
  end
end
