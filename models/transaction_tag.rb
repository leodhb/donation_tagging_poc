class TransactionTag
  attr_accessor :person, :non_profit, :amount, :date

  def initialize(person, non_profit, amount, type = :donation)
    @person     = person
    @non_profit = non_profit
    @amount     = amount
    @type       = type # donation, fee or increasing
    @date       = Time.now
  end
end
