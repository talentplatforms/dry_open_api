require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#tagObject
  class Tag
    prepend EquatableAsContent
    extend Dry::Initializer

    option :name, proc(&:to_s)
    option :description, proc(&:to_s), default: proc { nil }
    option :external_docs, default: proc { nil }

    def self.load(hash)
      return unless hash

      new(
        name: hash['name'],
        description: hash['description'],
        external_docs: ExternalDocumentation.load(hash['externalDocs']),
      )
    end
  end
end
