RSpec.describe DryOpenApi::Serializers::YamlSerializer do
  describe '#serialize' do
    subject { described_class.new.serialize(specification) }

    let(:specification) do
      DryOpenApi::Specification.new(
        openapi: '3.0.1',
        info: DryOpenApi::Info.new(
          title: 'Awesome API',
          description: 'It provides something awesome',
          version: '1.0.0'
        ),
        paths: DryOpenApi::Paths.new(
          '/pets': DryOpenApi::PathItem.new(
            get: DryOpenApi::Operation.new(
              description: 'Returns all pets from the system that the user has access to',
              responses: DryOpenApi::Responses.new(
                '200': DryOpenApi::Response.new(
                  description: 'A list of pets.',
                  content: {
                    'application/json': DryOpenApi::MediaType.new(
                      schema: DryOpenApi::Schema.new(
                        type: 'array',
                        items: DryOpenApi::Reference.new(ref: '#/components/schemas/pet')
                      )
                    )
                  }
                )
              )
            )
          )
        )
      )
    end

    it 'creates yaml string from specification object' do
      # these specs need " else they will fail!
      is_expected.to eq(
<<-EOL
---
openapi: 3.0.1
info:
  title: Awesome API
  description: It provides something awesome
  version: 1.0.0
paths:
  "/pets":
    get:
      description: Returns all pets from the system that the user has access to
      responses:
        '200':
          description: A list of pets.
          content:
            application/json:
              schema:
                type: array
                items:
                  "$ref": "#/components/schemas/pet"
EOL
      )
    end
  end

  describe '#deserialize' do
    subject { described_class.new.deserialize(yaml_string) }

    let(:yaml_string) do
<<-EOL
---
openapi: '3.0.1'
info:
  title: 'Awesome API'
  description: 'It provides something awesome'
  version: '1.0.0'
paths:
  /pets:
    get:
      description: 'Returns all pets from the system that the user has access to'
      responses:
        200:
          description: 'A list of pets.'
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/pet'
EOL
    end

    it 'creates an specification object from yaml string' do
      obj = DryOpenApi::Specification.new(
        openapi: '3.0.1',
        info: DryOpenApi::Info.new(
          title: 'Awesome API',
          description: 'It provides something awesome',
          version: '1.0.0'
        ),
        paths: DryOpenApi::Paths.new(
          '/pets': DryOpenApi::PathItem.new(
            get: DryOpenApi::Operation.new(
              description: 'Returns all pets from the system that the user has access to',
              responses: DryOpenApi::Responses.new(
                '200': DryOpenApi::Response.new(
                  description: 'A list of pets.',
                  content: {
                    'application/json': DryOpenApi::MediaType.new(
                      schema: DryOpenApi::Schema.new(
                        type: 'array',
                        items: DryOpenApi::Reference.new(ref: '#/components/schemas/pet')
                      )
                    )
                  }
                )
              )
            )
          )
        )
      )
      is_expected.to eq obj
    end
  end
end
