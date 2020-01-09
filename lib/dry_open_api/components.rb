require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#componentsObject
  class Components
    prepend EquatableAsContent
    extend Dry::Initializer

    option :schemas, default: proc { nil }
    option :responses, default: proc { nil }
    option :parameters, default: proc { nil }
    option :examples, default: proc { nil }
    option :request_bodies, default: proc { nil }
    option :headers, default: proc { nil }
    option :security_schemes, default: proc { nil }
    option :links, default: proc { nil }
    option :callbacks, default: proc { nil }

    # rubocop:disable Metrics/MethodLength
    def serializable_hash
      {
        'schemas' => schemas&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'responses' => responses&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'parameters' => parameters&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'examples' => examples&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'requestBodies' => request_bodies&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'headers' => headers&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'securitySchemes' => security_schemes&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'links' => links&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'callbacks' => callbacks&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h
      }.compact
    end

    # rubocop:disable Metrics/PerceivedComplexity
    def self.load(hash)
      return unless hash

      new(
        schemas: hash['schemas']&.map { |k, v| [k, Reference.load(v) || Schema.load(v)] }&.to_h,
        responses: hash['responses']&.map { |k, v| [k, Reference.load(v) || Response.load(v)] }&.to_h,
        parameters: hash['parameters']&.map { |k, v| [k, Reference.load(v) || Parameter.load(v)] }&.to_h,
        examples: hash['examples']&.map { |k, v| [k, Reference.load(v) || Example.load(v)] }&.to_h,
        request_bodies: hash['requestBodies']&.map { |k, v| [k, Reference.load(v) || RequestBody.load(v)] }&.to_h,
        headers: hash['headers']&.map { |k, v| [k, Reference.load(v) || Header.load(v)] }&.to_h,
        security_schemes: hash['securitySchemes']&.map { |k, v|
                                                         [k, Reference.load(v) || SecuritySchema.load(v)]
                                                       }&.to_h,
        links: hash['links']&.map { |k, v| [k, Reference.load(v) || Link.load(v)] }&.to_h,
        callbacks: hash['callbacks']&.map { |k, v| [k, Reference.load(v) || Callback.load(v)] }&.to_h
      )
    end
    # rubocop:enable Metrics/MethodLength, Metrics/PerceivedComplexity
  end
end
