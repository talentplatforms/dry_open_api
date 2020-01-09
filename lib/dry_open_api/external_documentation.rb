require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#externalDocumentationObject
  class ExternalDocumentation
    extend Dry::Initializer

    option :url, proc(&:to_s)
    option :description, proc(&:to_s), default: proc { nil }

    def self.load(hash)
      return unless hash

      new(
        description: hash['description'],
        url: hash['url']
      )
    end
  end
end
