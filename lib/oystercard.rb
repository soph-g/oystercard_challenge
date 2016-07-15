require_relative 'journey'

class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  attr_reader :balance, :journeys, :in_journey, :journey

  def initialize(balance = DEFAULT_BALANCE)
      @balance = balance
      @journeys = []
  end

  def top_up(amount)
      fail "Card limited to £90" if (@balance+amount) > MAXIMUM_BALANCE
      @balance += amount
      @balance
  end

  def touch_in(station)
    fail 'Insufficient balance' if @balance < Journey::MINIMUM_FARE
    @journey = Journey.new(station)
    @in_journey = true
    deduct(@journey.fare)
    @journeys << {entry_station: station}
  end

  def touch_out(station)
    in_journey? ? @journey : @journey = Journey.new
    @journey.finish(station)
    deduct(@journey.fare)
    @in_journey = false
    refund
    @journey = Journey.new
    #@journeys.last.store(:exit_station, station)
  end

  def in_journey?
    @in_journey
  end

private
  def deduct(amount)
      @balance -= amount
  end

  def refund
    @balance += journey.refund_amount
  end

end
