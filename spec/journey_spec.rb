require 'journey'

describe Journey do
  let(:station_entered) {double(:station)}
  subject(:journey) {described_class.new}
  let(:station_exited) {double(:station)}

  describe '#start' do
    it 'collects the entry station' do
      journey.start(station_entered)
      expect(journey.entry_station).to eq station_entered
    end
  end

  describe '#complete?' do
    it 'is marked as false when a journey starts' do
      journey.start(station_entered)
      expect(journey).not_to(be_complete)
    end
    it 'is marked as true when a journey finishes' do
      journey.start(station_entered)
      journey.finish(station_exited)
      expect(journey).to(be_complete)
    end
    it 'is marked as false if only exit station is provided' do
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
      journey.start(station_entered)
      journey.finish(station_exited)
      expect(journey.fare).to eq described_class::MINIMUM_FARE
    end
    it 'sets the cost of an incomplete journey with only a starting station' do
      journey.start(station_entered)
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end
    it 'sets the cost of an incomplete journey with only a finishing station' do
      journey.finish(station_exited)
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end
  end

end
