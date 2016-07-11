require 'oystercard'

describe OysterCard do
  subject(:oystercard) { described_class.new }

  it { is_expected.to(respond_to(:balance)) }
  it { is_expected.to (respond_to(:top_up).with(1).argument) }

  describe '#balance' do
    it 'has a balance of zero' do
      expect(oystercard.balance).to(eq(0))
    end
  end

  describe '#top_up' do
    it 'can top_up the balance' do
      expect{ oystercard.top_up 5 }.to change{ oystercard.balance }.by 5
    end
    it 'raises an error if the top up will take the balance over £90' do
      expect{ oystercard.top_up(100) }.to(raise_error("Balance cannot exceed £90"))
    end
  end

end
