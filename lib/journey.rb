
class Journey

  attr_reader :entry_station, :exit_station, :fare

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(station)
    @entry_station = station
    @in_journey = true
    @fare = PENALTY_FARE
  end

  def in_journey?
    @in_journey
  end

  def end_journey(station)
    complete_journey
    set_fare
    set_exit(station)
    self
  end

  private

  def set_fare
    @fare = MINIMUM_FARE
  end

  def complete_journey
    @in_journey = false
  end

  def set_exit(station)
    @exit_station = station
  end

end
