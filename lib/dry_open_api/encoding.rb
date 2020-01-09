require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#encodingObject
  class Encoding
    prepend EquatableAsContent
    extend Dry::Initializer

    option :content_type, proc(&:to_s), default: proc { nil }
    option :headers, default: proc { nil }
    option :style, proc(&:to_s), default: proc { nil }
    option :explode, default: proc { nil }
    option :allow_reserved, default: proc { false }

    def self.load(hash)
      new(
        content_type: hash['contentType'],
        headers: hash['headers']&.map { |k, v| [k, Reference.load(v) || Header.load(v)] }.to_h,
        style: hash['style'],
        explode: hash['explode'],
        allow_reserved: hash['allowReserved'].present?
      )
    end
  end
end
