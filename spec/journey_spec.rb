require 'journey'

describe Journey do
  let(:station) {double :station, zone: 1}
  subject(:journey) {described_class.new(station)}
  let(:other_station) {double :station, zone: 4}


  it 'captures the entry station' do
    expect(subject.entry_station).to eq(station)
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
      subject.end_journey(station)
      expect(subject.exit_station).to eq(station)
    end
    it 'sets end journey to false' do
      subject.end_journey(station)
      expect(subject).not_to be_in_journey
    end
    it 'returns itself when journey ends' do
      expect(subject.end_journey(station)).to eq(subject)
    end
    it 'charges the zone fare for each zone passed through' do
      allow(station).to(receive(:zone).and_return(4))
      allow(other_station).to(receive(:zone).and_return(1))
      subject.end_journey(other_station)
      expect(subject.fare).to(eq(4))
    end
  end

end
