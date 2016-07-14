class Journey

  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    fare
  end

def start(station)
  @entry_station = station
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
  @fare = complete? ? MINIMUM_FARE : PENALTY_FARE
  end
end
