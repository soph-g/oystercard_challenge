require 'journey_log'

describe JourneyLog do
  let(:card_with_money) { double(:card_with_money) }
  let(:trip) {[{ entry_station: station_entered, exit_station: station_exited }]}
  let(:station_entered) {("Old Street")}
  let(:station_exited) {("Waterloo")}
  let(:journey) { double(:journey, :MINIMUM_FARE => 1) }

  describe '#start' do
    before do
      allow(card_with_money).to receive(:touch_in)
    end
    it 'creates a new instance of journey' do
      card_with_money.touch_in(station_entered)
      subject.start(station_entered)
      expect(subject.journey).to(be_a(Journey))
    end
    it 'raises error if balance less than £1 while touching in' do
      expect{subject.touch_in(station_entered)}.to raise_error 'Insufficient balance'
    end
    it "remembers the entry station" do
      card_with_money.touch_in(station_entered)
    end
    it 'deducts the penalty fare when a journey is started' do
      call_journey = card_with_money.journey
      allow(call_journey).to receive(:fare).and_return(6)
      expect { card_with_money.touch_in(station_entered) }.to change {card_with_money.balance}.by(-call_journey.fare)
    end
  end

  describe '#touch_out' do
    it 'end the journey' do
      card_with_money.touch_in(station_entered)
      card_with_money.touch_out(station_exited)
      expect(card_with_money).not_to be_in_journey
    end
    it 'charges the penalty fare if only an exit station is provided' do
      allow(card_with_money.journey).to(receive(:finish))
      allow(card_with_money.journey).to(receive(:fare).and_return(6))
      expect{card_with_money.touch_out(station_exited)}.to change {card_with_money.balance}.by(-6)
    end
    it 'refunds the correct amount if both entry and exit stations are present' do
      card_with_money.touch_in(station_entered)
      allow(card_with_money.journey).to(receive(:fare).and_return(6))
      allow(card_with_money.journey).to(receive(:finish))
      allow(card_with_money.journey).to(receive(:refund_amount).and_return(5))
      expect{card_with_money.touch_out(station_exited)}.to change {card_with_money.balance}.by(-1)
    end
    it 'passes the exit station to the journey object' do
      card_with_money.touch_in(station_entered)
      expect(card_with_money.journey).to receive :finish
      card_with_money.touch_out(station_exited)
    end
  end

  describe '#in_journey?' do
    it "Is initally not in journey" do
      expect(subject).not_to be_in_journey
    end
    it 'checks if the user is in journey' do
      card_with_money.touch_in(station_entered)
      expect(card_with_money).to be_in_journey
    end
    it 'checks if the user isn\'t in journey' do
      card_with_money.touch_in(station_entered)
      card_with_money.touch_out(station_exited)
      expect(card_with_money).not_to be_in_journey
    end
  end
end
