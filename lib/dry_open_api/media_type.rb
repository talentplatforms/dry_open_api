require 'dry-initializer'

module DryOpenApi
  class MediaType
    prepend EquatableAsContent
    extend Dry::Initializer

    option :schema, default: proc { nil }
    option :example, default: proc { nil }
    option :examples, default: proc { nil }
    option :encoding, default: proc { nil }

    def serializable_hash
      {
        'schema' => schema&.serializable_hash,
        'example' => example,
        'examples' => examples&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'encoding' => encoding&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h
      }.compact
    end

    def self.load(hash)
      return unless hash

      indi_hash = hash.with_indifferent_access

      new(
        schema: Reference.load(indi_hash['schema']) || Schema.load(indi_hash['schema']),
        example: indi_hash['example'],
        examples: indi_hash['examples']&.map { |k, v| [k, Reference.load(v) || Example.load(v)] }&.to_h,
        encoding: indi_hash['encoding']&.map { |k, v| [k, Encoding.load(v)] }&.to_h
      )
    end
  end
end
