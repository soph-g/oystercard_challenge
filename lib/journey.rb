class Journey

  attr_reader :entry_station, :exit_station

  def initialize(station)
    @entry_station = station
    @complete = false
  end

  def complete?
    @complete
  end

  def finish(station)
    @exit_station = station
  end

end
