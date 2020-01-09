RSpec.describe DryOpenApi::Callback do
  it 'creates an instance' do
    path_item = double(:path_item)
    expect(
      described_class.new(
        'http://notificationServer.com?transactionId={$request.body#/id}&email={$request.body#/email}': path_item
      )
    ).to be_a(described_class)
  end

  describe '#[]' do
    subject { callback[expression] }

    let(:callback) { described_class.new(**{ expression.to_sym => path_item }) }
    let(:expression) { 'successUrls' }
    let(:path_item) { double(:path_item) }

    it 'returns path item' do
      is_expected.to eq path_item
    end
  end
end
