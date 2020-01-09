require 'dry-initializer'

module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#info-object
  class Info
    prepend EquatableAsContent
    extend Dry::Initializer

    option :title, proc(&:to_s)
    option :version, proc(&:to_s)
    option :description, default: proc { nil }
    option :terms_of_service, default: proc { nil }
    option :contact, default: proc { nil }
    option :license, default: proc { nil }

    def serializable_hash
      {
        'title' => title,
        'description' => description,
        'termsOfService' => terms_of_service,
        'contact' => contact&.serializable_hash,
        'license' => license&.serializable_hash,
        'version' => version
      }.compact
    end

    def self.load(hash)
      new(
        title: hash['title'],
        description: hash['description'],
        terms_of_service: hash['termsOfService'],
        contact: Contact.load(hash['contact']),
        license: License.load(hash['license']),
        version: hash['version']
      )
    end
  end
end
