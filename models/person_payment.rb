class PersonPayment
  attr_accessor :person, :amount, :date

  def initialize(person, amount)
    @person = person
    @amount = amount
    @date   = Time.now
  end
end
