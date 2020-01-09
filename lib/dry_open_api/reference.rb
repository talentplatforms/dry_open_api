require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#referenceObject
  class Reference
    prepend EquatableAsContent
    extend Dry::Initializer

    option :ref, proc(&:to_s)

    def serializable_hash
      { '$ref' => ref }
    end

    def self.load(hash)
      return unless hash && hash['$ref']

      new(ref: hash['$ref'])
    end
  end
end
