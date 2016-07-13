require 'journey'

class Oystercard
MAX_BALANCE = 90
MIN_BALANCE = 1
FARE = 1
  attr_reader :balance, :journeys

  def initialize()
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail top_up_error if balance_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail min_balance_error if below_min?
    @journeys << {entry_station: station}
  end

  def touch_out(station)
    deduct(FARE)
    @journeys.last.store(:exit_station, station)
  end

  def in_journey?
    !journeys.last.include?(:exit_station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def below_min?
    balance < MIN_BALANCE
  end

  def min_balance_error
    "Balance is below £#{MIN_BALANCE}"
  end

  def balance_exceeded?(amount)
    balance + amount > MAX_BALANCE
  end

  def top_up_error
    "Balance cannot exceed #{MAX_BALANCE}."
  end
end
