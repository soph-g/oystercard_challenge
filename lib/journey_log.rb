require_relative 'journey'

class JourneyLog

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  attr_reader :balance, :journeys, :in_journey, :journey

  def initialize(balance = DEFAULT_BALANCE)
      @balance = balance
      @journeys = []
  end

  def start(station)
    @journey = Journey.new(station)
    @in_journey = true
    deduct(@journey.fare)
    @journey
  end

  def touch_out(station)
    in_journey? ? nil : @journey = Journey.new
    @journey.finish(station)
    deduct(@journey.fare)
    @in_journey = false
    refund
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
