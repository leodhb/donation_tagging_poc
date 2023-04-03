# This is a Ribon application abstraction. With the needed models for tagging and a proposed solution for the problem.

# The logic is quite simple:
# 1. Person payments are a record of all payments made by a person (Positive amount) [remember to exclude refunds from this]
# 2. Transaction tags are a record of all transactions (PERSON -> NON_PROFIT) made by a user (Negative amount)
# 3. With this 2 records, we can calculate the amount of money available for a person to donate to a non profit (Balance)
#
# The problem is to determine the chosen person for a transaction tag. This is done by the DetermineChosenPerson class.
# The logic is quite simple:
# 1. If the person has donated more than 10k, it will be chosen 50% of the time
# 2. If the person has donated less than 10k, it will be chosen 50% of the time
# 3. If there are no people that have donated more than 10k, it will choose a person randomly
#
# The rules can be extended using rule group classes. In order to follow the rules proposed in the Rafa's presentation, I decided to keep it simple.
#
# The logic is in the DetermineChosenPerson class. The rest of the code is just to make it work.

require_relative 'models/person.rb'
require_relative 'models/non_profit.rb'
require_relative 'models/person_payment.rb'
require_relative 'models/transaction_tag.rb'
require_relative 'commands/determine_chosen_person.rb'
require_relative 'cli_presenter/presenter.rb'

class Ribon
  attr_accessor :people, :non_profits, :transaction_tags, :person_payments

  def initialize
    @people           = [] # guys who donate money to the fund
    @non_profits      = [] # guys who use the money from the fund
    @transaction_tags = [] # the tagging itself
    @person_payments  = [] # all payments made by a person
  end

  def donate_to_fund(name, amount)
    person = @people.find { |p| p.name == name }

    if person
      @person_payments << PersonPayment.new(person, amount)
    else
      new_person        = Person.new(name, amount)
      @people          << new_person
      @person_payments << PersonPayment.new(new_person, amount)
    end
  end

  def use_ticket(non_profit)
    donor = DetermineChosenPerson.new(self, non_profit).call

    if donor
      @transaction_tags << TransactionTag.new(donor, non_profit, non_profit.default_ticket)
    else
      puts "No donors with enough funds available"
    end
  end

  def report
    Presenter.new(self).call
  end
end
