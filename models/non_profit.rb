class NonProfit
  attr_accessor :name, :default_ticket

  def initialize(name, default_ticket = 5)
    @name           = name
    @default_ticket = default_ticket
  end
end
