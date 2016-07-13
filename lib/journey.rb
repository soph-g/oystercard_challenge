
class Journey

  attr_reader :entry_station, :exit_station, :penalty_fare, :minimum_fare, :fare

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(station)
    @entry_station = station
    @in_journey = true
    @penalty_fare = PENALTY_FARE
    @minimum_fare = MINIMUM_FARE
    calculate_fare
  end

  def in_journey?
    @in_journey
  end

  def exit_station(station)
    @in_journey = false
    calculate_fare
    @exit_station = station
  end

  def calculate_fare
    if in_journey?
      @fare = penalty_fare
    else
      @fare = minimum_fare
    end
  end

end
