require 'oystercard'

describe Oystercard do
  let(:card_with_money) { Oystercard.new(10) }
  let(:journey) {[{ entry_station: station_entered, exit_station: station_exited }]}
  let(:station_entered) {("Old Street")}
  let(:station_exited) {("Waterloo")}

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

    it 'tells your balance is 0' do
        expect(subject.balance).to eq 0
    end

  describe '#top_up' do
   it 'tells you when you top up' do
       expect{subject.top_up(Oystercard::MINIMUM_FARE)}.to change{subject.balance}.by(Oystercard::MINIMUM_FARE)
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
      card_with_money.touch_in(station_entered)
      expect(card_with_money.journeys).to include station_entered
    end
  end

  describe '#touch_out' do
    it 'end the journey' do
      subject.touch_out(station_exited)
      expect(subject).not_to be_in_journey
    end
    it 'charges the user when touching out' do
      card_with_money.touch_in(station_entered)
      expect { card_with_money.touch_out(station_exited) }.to change {card_with_money.balance}.by(-Oystercard::MINIMUM_FARE)
    end

    it 'stores a journey' do
      card_with_money.touch_in(station_entered)
      card_with_money.touch_out(station_exited)
      expect(card_with_money.journeys).to match journey
    end
    it "journeys knows it's touch out station" do
      card_with_money.touch_in(station_entered)
      card_with_money.touch_out(station_exited)
      expect(card_with_money.journeys).to include ({:exit_station => "#{station_exited}"})
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
