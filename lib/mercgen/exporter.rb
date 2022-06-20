class Mercgen::Exporter
  attr_accessor :data
  def initialize(data)
    @data = data
  end

  def export(path, name)
    File.open(path, 'w') do |f|
      f << format(name)
    end
  end

  def format(name)
    <<~OUTPUT
      #modname "Mercgen-#{name}"
      #description "A Selection of random mercenary companies, generated with version #{Mercgen::VERSION}. This pack contains #{data.length} companies."
      #clearmercs
      #{companies}}
    OUTPUT
  end

  def companies
    output = ''
    data.each_with_index do |d, index|
      commander = d[:commander]
      unit = d[:units]

      size = d[:unit_number] > 100 ? "legion" : d[:unit_number] > 50 ? "horde" : "company"
      commander_name = NAMELIST.sample
      level = d[:cost] > 500 ? 2 : d[:cost] > 250 ? 1 : 0
      output += "\n" if index > 0
      output += <<~COMPANY
        #newmerc
        #name "#{commander_name}'s #{size} of #{unit[:name]}"

        #level #{level}
        #bossname "#{commander_name}"
        #com "#{commander[:name]}"
    
        #unit "#{unit[:name]}"
        #nrunits #{d[:unit_number]}

        #minmen #{(d[:unit_number] / 4).to_i}

        #minpay #{d[:cost]}

        #xp #{(0..100).to_a.sample}

        #randequip #{[0,1,2,3].sample}

        #recrate 200

        #eramask 7

        #end
      COMPANY
    end

    output
  end


  NAMELIST = %w(
    Halvdan
    Karina
    Didier
    Arnbjørg
    Arjun
    Ifor
    Farrokh
    Sahnaz
    Drew
    Bellamy
    Anik
    Murali
    Daedalus
    Antonija
    Ami
    Sanjana
    Demetra
    Malik
    Nadezhda
    BalefulWraith 
  )
end
