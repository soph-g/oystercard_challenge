class OysterCard
  attr_reader :balance

  MAXIMUM_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up amount
    fail "Balance cannot exceed £90" if exceed_limit?(amount)
    @balance += amount
  end

  def exceed_limit?(amount)
    (@balance + amount) > 90

  end

end
