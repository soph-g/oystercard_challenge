class Journey

  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(station = nil)
    @entry_station = station
    fare
  end

  def complete?
    !!entry_station && !!exit_station
  end

  def finish(station)
    @exit_station = station
    fare
    self
  end

  def fare
  complete? ? 0 : PENALTY_FARE
  end

  def refund_amount
    complete? ? 5 : 0
  end

end
