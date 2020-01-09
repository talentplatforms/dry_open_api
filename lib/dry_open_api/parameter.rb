module DryOpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#parameterObject
  class Parameter
    prepend EquatableAsContent

    attr_accessor :name, :in, :description, :required, :deprecated, :allow_empty_value

    # rubocop:disable Metrics/MethodLength, Metrics/ParameterLists
    def initialize(name:, in:, description: nil, required: nil, deprecated: nil, allow_empty_value: nil, **other_fields_hash)
      self.name = name
      self.in = binding.local_variable_get(:in) # `in` is reserved keyword
      self.required = required
      self.deprecated = deprecated
      self.allow_empty_value = allow_empty_value
      self.other_fields_hash = other_fields_hash.with_indifferent_access

      other_fields_hash.keys.each do |key|
        define_singleton_method(key) do
          other_fields_hash[key]
        end
        define_singleton_method("#{key}=") do |value|
          other_fields_hash[key] = value
        end
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/ParameterLists

    def self.load(hash)
      other_fields_hash = hash.reject { |key|
        key.to_sym.in?([:name, :in, :description, :required, :deprecated, :allow_empty_value])
      }.symbolize_keys.map { |k, v|
        value =
          case k
          when :schema then Schema.load(v)
          end
        [k, value]
      }.to_h

      new(
        name: hash['name'].to_s,
        in: hash['in'].to_s,
        description: hash['description']&.to_s,
        required: hash['required'],
        deprecated: hash['deprecated'],
        allow_empty_value: hash['allowEmptyValue'],
        **other_fields_hash
      )
    end

    def serializable_hash
      {
        'name' => name.to_s,
        'in' => self.in.to_s,
        'required' => required,
        'deprecated' => deprecated,
        'allow_empty_value' => allow_empty_value
      }.merge(
        other_fields_hash.map { |k, v| [k.to_s, v.serializable_hash] }.to_h
      ).compact
    end

    private

    attr_accessor :other_fields_hash
  end
end
