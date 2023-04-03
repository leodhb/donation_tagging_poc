def c_debug(color, text)
  colors = {
    red: "\e[31m",
    green: "\e[32m",
    yellow: "\e[33m",
    blue: "\e[34m",
    magenta: "\e[35m",
    cyan: "\e[36m"
  }
  
  if colors.key?(color.to_sym)
    puts "#{colors[color.to_sym]}#{text}\e[0m"
  else
    puts text
  end
end

def pick_name
  names = ["messi", "richarlison", "leod", "nick", "yan", "tata", "nath", "let", "clara", "juju", "lulu"]
  names.sample
end

require_relative 'ribon.rb'

def initialize_ribon
  @ribon = Ribon.new
  @ribon.non_profits = [NonProfit.new("Evidence Action"), NonProfit.new("Casa do Menino Jesus")]
  @ribon
end

def ribon
  @ribon ||= initialize_ribon
end

initialize_ribon
# ribon.donate_to_fund "leod", 19_95
# ribon.use_ticket ribon.non_profits.sample