require 'dry-initializer'

module DryOpenApi
  # represents a single response object
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.2.md#responsesObject
  class Response
    prepend EquatableAsContent
    extend Dry::Initializer

    option :description, proc(&:to_s)

    # rubocop:disable Style/Lambda
    option :headers, ->(headers_param) {
      return if headers_param.nil?

      headers_param.to_h.with_indifferent_access
    }, default: proc { nil }

    option :content, ->(content_param) {
      return if content_param.nil?

      content_param.to_h.with_indifferent_access
    }, default: proc { nil }

    option :links, ->(links_param) {
      return if links_param.nil?

      links_param.to_h.with_indifferent_access
    }, default: proc { nil }

    # rubocop:enable Style/Lambda

    def serializable_hash
      {
        'description' => description,
        'headers' => headers&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'content' => content&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h,
        'links' => links&.map { |k, v| [k.to_s, v.serializable_hash] }&.to_h
      }.compact
    end

    def self.load(hash)
      return unless hash

      indi_hash = hash.with_indifferent_access

      new(
        description: indi_hash['description'],
        headers: indi_hash['headers']&.map { |k, v| [k, Header.load(v)] }&.to_h,
        content: indi_hash['content']&.map { |k, v| [k, MediaType.load(v)] }&.to_h,
        links: indi_hash['links']&.map { |k, v| [k, Reference.load(v) || Link.load(v)] }&.to_h
      )
    end
  end
end
