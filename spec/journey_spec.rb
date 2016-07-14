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
  end

end
