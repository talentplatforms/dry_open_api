module DryOpenApi
  DataType = Struct.new(:name, :type, :format)

  # defines the DataTypes defined by the spec and adds some shortcuts
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#data-types
  class DataTypes
    @data = [
      DataType.new(:integer, :integer, :int32),
      DataType.new(:long, :integer, :int64),
      DataType.new(:float, :number, :float),
      DataType.new(:double, :number, :double),
      DataType.new(:string, :string),
      DataType.new(:byte, :string, :byte),
      DataType.new(:binary, :string, :binary),
      DataType.new(:uuid, :string, :uuid),
      DataType.new(:email, :string, :email),
      DataType.new(:boolean, :boolean),
      DataType.new(:date, :string, :date),
      DataType.new(:dateTime, :string, :"date-time"),
      DataType.new(:password, :string, :password)
    ]

    def self.all
      @data
    end

    def self.all_types
      all.map(&:type).uniq
    end
  end
end
