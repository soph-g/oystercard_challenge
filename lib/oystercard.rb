require_relative 'journey'

class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  attr_reader :balance, :journeys, :in_journey, :journey
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
      @balance = balance
      @journey = Journey.new
      @journeys = []
  end

  def top_up(amount)
      fail "Card limited to £90" if (@balance+amount) > MAXIMUM_BALANCE
      @balance += amount
      @balance
  end

  def touch_in(station)
    fail 'Insufficient balance' if @balance < MINIMUM_FARE
    @journey.start(station)
    @in_journey = true
    @journeys << {entry_station: station}
  end

  def touch_out(station)
    @journey.finish(station)
    deduct(@journey.fare)
    @in_journey = false
    @journeys.last.store(:exit_station, station)
  end

  def in_journey?
    @in_journey
  end

private
  def deduct(amount)
      @balance -= amount
  end
end
