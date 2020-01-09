RSpec.describe DryOpenApi do
  it 'has a version number' do
    expect(DryOpenApi::VERSION).not_to be nil
  end

  it 'creates simple spec' do
    spec = DryOpenApi::Specification.new(
      openapi: '3.0.1',
      info: DryOpenApi::Info.new(
        title: 'Awesome API',
        version: '1.0.0'
      ),
      paths: DryOpenApi::Paths.new(
        '/books': DryOpenApi::PathItem.new(
          get: DryOpenApi::Operation.new(
            responses: DryOpenApi::Responses.new(
              '200': DryOpenApi::Response.new(
                description: 'array of book',
                content: {
                  'application/json' => DryOpenApi::Reference.new(ref: '#/components/schemas/Book')
                }
              )
            )
          ),
          post: DryOpenApi::Operation.new(
            responses: DryOpenApi::Responses.new(
              '201': DryOpenApi::Response.new(
                description: 'created book',
                content: {
                  'application/json' => DryOpenApi::Reference.new(ref: '#/components/schemas/Book')
                }
              )
            )
          )
        )
      )
    )
    expect(spec).to be_a(DryOpenApi::Specification)
    expect(spec.paths['/books'].operations[:get].responses['200'].description).to eq 'array of book'
    expect(spec.paths['/books'].operations[:get].responses['200'].content['application/json'].ref).to eq '#/components/schemas/Book'
    expect(spec.paths['/books'].operations[:post].responses['201'].description).to eq 'created book'
    expect(spec.paths['/books'].operations[:post].responses['201'].content['application/json'].ref).to eq '#/components/schemas/Book'
  end
end
