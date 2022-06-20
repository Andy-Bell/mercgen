require_relative './data_processing/filterer'
require_relative './data_processing/importer'
require_relative './pricing_calculator'
require_relative './exporter'

require 'byebug'

class Mercgen::Generator
  attr_accessor :data, :filterer, :total, :output_path, :generated, :calculator, :name

  def initialize(name, output_path, total)
    importer = Mercgen::DataProcessing::Importer.new("#{__dir__}/../data/BaseU.csv")
    @data = importer.data
    @filterer = Mercgen::DataProcessing::Filterer.new(data)
    @filterer.hard_remove_if_true(:unique, 1)
    @filterer.hard_remove_if_true(:name, "Blood Slave")
    @filterer.hard_remove_if_present(:latehero)
    @calculator = Mercgen::PricingCalculator.new

    @total = total
    @output_path = output_path
    @name = name
  end

  def run
    @generated = Array.new(total).map do |_|
      commander = fetch_commander

      unit_type = fetch_unit_type(commander)

      unit_number = unit_size(commander, unit_type)

      cost = calculator.calculate(commander, unit_type, unit_number)

      { commander: commander, units: unit_type, unit_number: unit_number, cost: cost }
    end

    export
  end

  def export
    Mercgen::Exporter.new(generated).export(output_path, name)
  end
  
  def fetch_commander
    pool = filterer.keep_if_greater(:leader, 10)

    pool.sample
  end

  def fetch_unit_type(commander)
    search = data
    
    search = Mercgen::DataProcessing::Filterer.new(search).remove_if_true(:magicbeing, 1) if commander[:magicleader].nil?
    search = Mercgen::DataProcessing::Filterer.new(search).remove_if_true(:undead, 1) if commander[:undeadleader].nil?

    search.sample
  end

  def unit_size(commander, unit)
    leadership_value = :leader
    leadership_value = :magicleader if unit[:magicbeing] == 1
    leadership_value = :undeadleader if unit[:undead] ==1

    lowest = commander[leadership_value] <= 20 ? commander[leadership_value] : (commander[leadership_value] / 2).to_i
    highest = commander[leadership_value]

    range = lowest..highest
    
    range.to_a.sample
  end
end
