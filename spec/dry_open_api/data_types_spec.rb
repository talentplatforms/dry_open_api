RSpec.describe DryOpenApi::DataTypes do
  describe '.all' do
    subject { described_class.all }

    it { is_expected.to be_a Array }
    it { is_expected.to include an_instance_of(DryOpenApi::DataType) }
  end

  describe '.all_types' do
    subject { described_class.all_types }

    it { is_expected.to be_a Array }
    it { is_expected.to include an_instance_of(Symbol) }
  end
end
