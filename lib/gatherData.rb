#!/usr/bin/env ruby

class Gatherdata
  def getdata_ina219(milliamp_measure)
    result = exec("python /etc/Project-Erebus/lib/return_ina219.py #{milliamp_measure}")
    puts "INA219 return is: #{result}"
  end
end

gather = Gatherdata.new
gather.getdata_ina219(0.03)
