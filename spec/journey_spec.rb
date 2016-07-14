require 'journey'

describe Journey do
  let(:station_entered) {double(:station)}
  subject(:journey) {described_class.new(station_entered)}
  let(:station_exited) {double(:station)}


  it 'starts the journey and collects the entry station' do
    expect(journey.entry_station).to eq station_entered
  end

  describe '#complete?' do
    it 'is marked as false when a journey starts' do
      expect(journey).not_to(be_complete)
    end
    it 'is marked as true when a journey finishes' do
      journey.finish(station_exited)
      expect(journey).to(be_complete)
    end
    it 'is marked as false if only exit station is provided' do
      journey = described_class.new
      journey.finish(station_exited)
      expect(journey).not_to(be_complete)
    end
  end
  describe '#finish' do
    it 'captures the exit station when a journey ends' do
      journey.finish(station_exited)
      expect(journey.exit_station).to(eq(station_exited))
    end
    it 'expects journey to receive fare' do
      expect(journey).to receive(:fare)
      journey.finish(station_exited)
    end
  end

  describe '#fare' do
    it 'sets the cost of the completed journey' do
      journey.finish(station_exited)
      expect(journey.fare).to eq described_class::STANDARD_FARE
    end
    it 'sets the cost of an incomplete journey with only a starting station' do
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end
    it 'sets the cost of an incomplete journey with only a finishing station' do
      exit_only = Journey.new
      exit_only.finish(station_exited)
      expect(exit_only.fare).to eq described_class::PENALTY_FARE
    end
  end

end
