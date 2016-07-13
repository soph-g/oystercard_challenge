
class Journey

attr_reader :entry_station, :exit_station

  def initialize(station)
    @entry_station = station
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def exit_station(station)
    @exit_station = station
  end

end
