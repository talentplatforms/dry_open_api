require 'dry-initializer'

module DryOpenApi
  # no corresponding thing in the spec
  class Operation
    prepend EquatableAsContent
    extend Dry::Initializer

    option :responses
    option :description, default: proc { nil }
    option :summary, default: proc { nil }
    option :operation_id, default: proc { nil }
    option :tags, default: proc { nil }
    option :external_docs, default: proc { nil }
    option :parameters, default: proc { nil }
    option :request_body, default: proc { nil }
    option :callbacks, default: proc { nil }
    option :deprecated, default: proc { nil }
    option :security, default: proc { nil }
    option :servers, default: proc { nil }

    # rubocop:disable Metrics/MethodLength
    def serializable_hash
      {
        'description' => description,
        'responses' => responses.serializable_hash,
        'tags' => tags&.map(&:to_s),
        'summary' => summary,
        'externalDocs' => external_docs&.serializable_hash,
        'operationId' => operation_id,
        'parameters' => parameters&.map(&:serializable_hash),
        'requestBody' => request_body&.serializable_hash,
        'callbacks' => callbacks&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'deprecated' => deprecated,
        'security' => security&.map(&:serializable_hash),
        'servers' => servers&.map(&:server)
      }.compact
    end

    def self.load(hash)
      return unless hash

      new(
        responses: Responses.load(hash['responses']),
        tags: hash['tags'],
        summary: hash['summary'],
        description: hash['description'],
        external_docs: ExternalDocumentation.load(hash['externalDocs']),
        operation_id: hash['operationId'],
        parameters: hash['parameters']&.map { |h| Reference.load(h) || Parameter.load(h) },
        request_body: Reference.load(hash['requestBody']) || RequestBody.load(hash['requestBody']),
        callbacks: hash['callbacks']&.map { |k, v| [k, Reference.load(v) || Callback.load(v)] }&.to_h,
        deprecated: hash['deprecated'],
        security: hash['security']&.map { |h| SecurityRequirement.load(h) },
        servers: hash['servers']&.map { |h| Server.load(h) }
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
