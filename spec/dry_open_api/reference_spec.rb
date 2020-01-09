RSpec.describe DryOpenApi::Reference do
  it 'creates an instance' do
    expect(described_class.new(ref: '#/components/schemas/Book')).to be_a(described_class)
    expect(described_class.new(ref: 'Book.json')).to be_a(described_class)
  end

  describe '.load' do
    subject { described_class.load(hash) }

    let(:hash) { { '$ref' => '#/components/schemas/Pet' } }

    it 'ceates an instance from hash' do
      is_expected.to eq described_class.new(ref: '#/components/schemas/Pet')
    end
  end
end
