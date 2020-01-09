require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#license-object
  class License
    extend Dry::Initializer

    option :name, proc(&:to_s)
    option :url, proc(&:to_s), default: proc { nil }

    def self.load(hash)
      return unless hash

      new(
        name: hash['name'],
        url: hash['url']
      )
    end
  end
end
