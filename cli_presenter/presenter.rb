class Presenter
  def initialize(ribon)
    @people           = ribon.people
    @non_profits      = ribon.non_profits
    @transaction_tags = ribon.transaction_tags
    @person_payments  = ribon.person_payments
  end

  def call
    @people.each do |person|
      person_transaction_tags = @transaction_tags.select { |d| d.person == person }
      person_payments         = @person_payments.select { |p| p.person == person }

      transaction_tags_sum                = person_transaction_tags.sum(&:amount)
      transaction_tags_sum_per_non_profit = person_transaction_tags.group_by(&:non_profit).map { |k, v| [k, v.sum(&:amount)] }
      payments_sum                        = person_payments.sum(&:amount)

      puts "==============================================="
      puts "\e[32m#{person.name} donated $#{ic(payments_sum)} and $#{ic(transaction_tags_sum)} was used\e[0m"
      report_progress_bar(payments_sum, transaction_tags_sum)
      transaction_tags_sum_per_non_profit.each do |non_profit, amount|
        puts "VALUE: \e[32m$#{ic(amount).to_s.ljust(8)}\e[0m FROM: #{person.name.ljust(10)} TO: \e[35m#{non_profit.name}\e[0m"
      end
    end
    puts "==============================================="
    nil
  end

  private

  def report_progress_bar(total_amount, used_amount)
    progress = (used_amount.to_f / total_amount.to_f) * 100
    # horizontal progress bar
    puts "Progress: #{progress.round(2)}%"
  end

  # integer with cents to string with dot
  def ic(integer)
    decimal = integer % 100
    decimal = "0#{decimal}" if decimal < 10
    integer = integer / 100
    integer_str = integer.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1.').reverse
    "#{integer_str}.#{decimal}"
  end
end
