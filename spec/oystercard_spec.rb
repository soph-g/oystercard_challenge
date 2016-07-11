require 'oystercard'

describe OysterCard do
  subject(:oystercard) { described_class.new }

  it { is_expected.to(respond_to(:balance)) }

  describe '#balance' do
    it 'has a balance of zero' do
      expect(oystercard.balance).to(eq(0))
    end
  end

end
