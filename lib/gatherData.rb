#!/usr/bin/env ruby

class Gatherdata
  def initialize(milliamp_measure)
    @milliamp_measure = milliamp_measure
  end

  def getdata_ina219
    result = exec("python /etc/Project-Erebus/bin/return_ina219.py 0.03")
    puts "INA219 return is: #{result}"
  end
end

gather = Gatherdata.new(0.03)
