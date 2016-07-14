class Journey

  attr_reader :entry_station, :exit_station

  STANDARD_FARE = 1
  PENALTY_FARE = 6

  def initialize(station = nil)
    @entry_station = station
    @complete = false
  end

  def complete?
    @complete
  end

  def finish(station)
    @exit_station = station
    @complete = true
  end

  def fare
  !!entry_station && !!exit_station ? STANDARD_FARE : PENALTY_FARE

  end
end
