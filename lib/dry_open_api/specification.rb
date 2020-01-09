require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#oasObject
  class Specification
    prepend EquatableAsContent
    extend Dry::Initializer

    option :openapi, proc(&:to_s)
    option :info
    option :paths
    option :servers, default: proc { nil }
    option :components, default: proc { nil }
    option :security, default: proc { nil }
    option :tags, default: proc { nil }
    option :external_docs, default: proc { nil }

    def serializable_hash
      {
        'openapi' => openapi,
        'info' => info.serializable_hash,
        'paths' => paths.serializable_hash,
        'components' => components&.serializable_hash,
        'security' => security&.map(&:serializable_hash),
        'tags' => tags&.map(&:serializable_hash),
        'externalDocs' => external_docs&.serializable_hash
      }.compact
    end

    def self.load(hash)
      return unless hash

      new(
        openapi: hash['openapi'],
        info: Info.load(hash['info']),
        paths: Paths.load(hash['paths']),
        components: Components.load(hash['components']),
        security: hash['security']&.map { |requirement_hash| SecurityRequirement.load(requirement_hash) },
        tags: hash['tags']&.map { |tag_hash| Tag.load(tag_hash) },
        external_docs: ExternalDocumentation.load(hash['externalDocs'])
      )
    end
  end
end
