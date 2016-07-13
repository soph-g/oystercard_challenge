require_relative 'station'

class Journey

  attr_reader :entry_station, :exit_station, :fare

  PENALTY_FARE = 6
  ZONE_FARE = 1

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
    set_exit(station)
    set_fare
    self
  end

  private

  def set_fare
    calculate_zones
    @fare = ZONE_FARE * @zones
  end

  def calculate_zones
    @zones = [exit_station.zone, entry_station.zone]
    @zones = (@zones.sort.reverse.reduce(:-)) + 1
  end

  def complete_journey
    @in_journey = false
  end

  def set_exit(station)
    @exit_station = station
  end

end
