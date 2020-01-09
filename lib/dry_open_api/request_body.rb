require 'dry-initializer'

module DryOpenApi
  class RequestBody
    prepend EquatableAsContent
    extend Dry::Initializer

    option :content
    option :description, proc(&:to_s), default: proc { nil }
    option :required, default: proc { false }

    def self.load(hash)
      return unless hash

      new(
        description: hash['description'],
        content: hash['content'].map { |k, v| [k, MediaType.load(v)] }.to_h,
        required: hash['required'].present?
      )
    end
  end
end
