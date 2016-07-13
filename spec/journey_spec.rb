require 'journey'

describe Journey do

  subject(:journey) {described_class.new(:station)}
  let(:station) {double :station}

  it 'captures the entry station' do
    expect(subject.entry_station).to eq(:station)
  end

  it 'assigns the penalty fare by default' do
    expect(subject.fare).to(eq(Journey::PENALTY_FARE))
  end

  describe '#in_journey' do
    it 'is initialy in journey' do
      expect(subject).to be_in_journey
    end
  end

  describe '#end_journey' do
    it 'records the exit station' do
      subject.end_journey(:station)
      expect(subject.exit_station).to eq(:station)
    end
    it 'sets end journey to false' do
      subject.end_journey(station)
      expect(subject).not_to be_in_journey
    end
    it 'assigns the minimum fare when a journey is completed' do
      subject.end_journey(station)
      expect(subject.fare).to(eq(Journey::MINIMUM_FARE))
    end
    it 'returns itself when journey ends' do
      expect(subject.end_journey(station)).to eq(subject)
    end
  end
end
