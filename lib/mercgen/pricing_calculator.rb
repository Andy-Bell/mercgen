require 'smarter_csv'

class Mercgen::PricingCalculator
  attr_accessor :data

  def initialize
    @data = SmarterCSV.process("#{__dir__}/../data/pricing_data.csv")
  end

  def calculate(commander, unit, unit_number)
    total = price_commander(commander)
    total += price_units(unit, unit_number)

    (total / 5).to_i
  end

  def price_commander(commander)
    pricing_hash = data.find{ |d| d[:id] == commander[:id]}
    pricing_hash[:comcost]
  end

  def price_units(unit, unit_number)
    pricing_hash = data.find{ |d| d[:id] == unit[:id]}
    price = pricing_hash[:unitcost]

    price * unit_number
  end
end