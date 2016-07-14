class Journey

  attr_reader :entry_station, :exit_station

  STANDARD_FARE = 1
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
  @fare = complete? ? STANDARD_FARE : PENALTY_FARE
  end
end
