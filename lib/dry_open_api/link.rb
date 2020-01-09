module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#link-object
  class Link
    prepend EquatableAsContent

    attr_accessor :operation_ref, :operation_id, :parameters, :request_body, :description, :server

    def initialize(operation_ref: nil, operation_id: nil, parameters: nil, request_body: nil, description: nil, server: nil, **other_fields_hash)
      self.operation_ref = operation_ref
      self.operation_id = operation_id
      self.parameters = parameters
      self.request_body = request_body
      self.description = description
      self.server = server
      self.other_fields_hash = other_fields_hash.with_indifferent_access

      other_fields_hash.keys.each do |field_name|
        define_singleton_method(field_name) do
          other_fields_hash[field_name]
        end
        define_singleton_method("#{field_name}=") do |value|
          other_fields_hash[field_name] = value
        end
      end
    end

    def self.load(hash)
      return unless hash

      fixed_field_names = %i[operationRef operationId parameters requestBody description server]
      other_fields_hash = hash.reject { |key|
        key.to_sym.in?(fixed_field_names)
      }.symbolize_keys

      new(
        operation_ref: hash['operationRef']&.to_s,
        operation_id: hash['operationId']&.to_s,
        parameters: hash['parameters'],
        request_body: RequestBody.load(hash['requestBody']),
        description: hash['description']&.to_s,
        server: Server.load(hash['server']),
        **other_fields_hash
      )
    end

    private

    attr_accessor :other_fields_hash
  end
end
