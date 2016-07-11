require 'oystercard'

describe OysterCard do
  subject(:oystercard) { described_class.new }

  it { is_expected.to(respond_to(:balance)) }
  it {is_expected.to (respond_to(:top_up).with(1).argument)}

  describe '#balance' do
    it 'has a balance of zero' do
      expect(oystercard.balance).to(eq(0))
    end
  end
  describe '#top_up' do
  it 'increases the balance with a given amount' do
    oystercard.top_up 10
    expect(oystercard.balance).to eq 10
  end
  end
end
