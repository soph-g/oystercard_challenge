require 'oystercard'

describe Oystercard do
  let(:card_with_money) { Oystercard.new(10) }
  let(:trip) {[{ entry_station: station_entered, exit_station: station_exited }]}
  let(:station_entered) {("Old Street")}
  let(:station_exited) {("Waterloo")}
  let(:journey) { double(:journey) }

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  it 'creates a new instance of journey' do
    expect(subject.journey).to be_a Journey
  end

    it 'tells your balance is 0' do
        expect(subject.balance).to eq 0
    end

  describe '#top_up' do
   it 'tells you when you top up' do
       expect{subject.top_up(1)}.to change{subject.balance}.by(1)
      end
   end

   it 'tells you there is a £90 limit' do
       maximum_balance = Oystercard::MAXIMUM_BALANCE
       card = Oystercard.new(maximum_balance)
       expect{card.top_up(maximum_balance)}.to raise_error "Card limited to £#{maximum_balance}"
   end

  describe '#touch_in' do
    it 'starts the journey' do
      card_with_money.touch_in(station_entered)
      expect(card_with_money).to be_in_journey
    end
    it 'raises error if balance less than £1 while touching in' do
      expect{subject.touch_in(station_entered)}.to raise_error 'Insufficient balance'
    end
    it "remembers the entry station" do
      expect(card_with_money.journey).to receive :start
      card_with_money.touch_in(station_entered)
    end
  end

  describe '#touch_out' do
    it 'end the journey' do
      card_with_money.touch_in(station_entered)
      card_with_money.touch_out(station_exited)
      expect(card_with_money).not_to be_in_journey
    end
    it 'receives the correct fare for completed journey' do
      call_journey = card_with_money.journey
      allow(call_journey).to receive :start
      card_with_money.touch_in(station_entered)
      allow(call_journey).to receive :finish
      allow(call_journey).to receive(:fare).and_return(1)
      expect { card_with_money.touch_out(station_exited) }.to change {card_with_money.balance}.by(-call_journey.fare)
    end
    it 'receives the correct fare for starting station incompleted journey' do
      call_journey = card_with_money.journey
      allow(call_journey).to receive :start
      allow(call_journey).to receive(:fare).and_return(6)
      expect { card_with_money.touch_in(station_entered) }.to change {card_with_money.balance}.by(-call_journey.fare)
    end
    it 'stores a journey' do
      card_with_money.touch_in(station_entered)
      card_with_money.touch_out(station_exited)
      expect(card_with_money.journeys).to match trip
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
