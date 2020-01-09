require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#contactObject
  class Contact
    prepend EquatableAsContent
    extend Dry::Initializer

    option :name, proc(&:to_s), default: proc { nil }
    option :url, proc(&:to_s), default: proc { nil }
    option :email, proc(&:to_s), default: proc { nil }

    def self.load(hash)
      return unless hash

      new(
        name: hash['name'],
        url: hash['url'],
        email: hash['email']
      )
    end
  end
end
