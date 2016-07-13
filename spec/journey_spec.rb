require 'journey'

describe Journey do

  subject(:journey) {described_class.new(:station)}
  let(:station) {double :station}

  it 'captures the entry station' do
    expect(subject.entry_station).to eq(:station)
  end

  describe '#in_journey' do
    it 'is initialy in journey' do
      expect(subject).to be_in_journey
    end
  end

  describe '#exit_station' do
    it 'records the exit station' do
      expect(subject.exit_station(:station)).to eq(:station)
    end
  end
end
