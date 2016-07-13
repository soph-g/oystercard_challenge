require 'journey'

describe Journey do

  subject(:journey) {described_class.new(:station)}
  let(:station) {double :station}

  it 'captures the entry station' do
    expect(subject.entry_station).to eq(:station)
  end

  it 'has a default pentaly fair' do
    expect(subject.penalty_fare).to(eq(Journey::PENALTY_FARE))
  end

  it 'has a minimum fare' do
    expect(subject.minimum_fare).to(eq(Journey::MINIMUM_FARE))
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

  describe '#calculate_fare' do
    it 'assigns the penalty fare by default' do
      expect(subject.fare).to(eq(Journey::PENALTY_FARE))
    end
    it 'assigns the minimum fare when a journey is completed' do
      subject.exit_station(station)
      expect(subject.fare).to(eq(Journey::MINIMUM_FARE))
    end
  end

end
