class Journey

  attr_reader :entry_station

  def initialize(station)
    @entry_station = station
    @complete = false
  end

  def complete?
    @complete
  end

end
