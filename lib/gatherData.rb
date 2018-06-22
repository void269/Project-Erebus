#!/usr/bin/env ruby

class Gatherdata
  def initialize
    @milliamp_measure = 0.03
  end

  def getdata_ina219
    result = exec("python /etc/Project-Erebus/bin/return_ina219.py 0.03")
    puts "INA219 return is: #{result}"
    return result
    #return "you got the data!"
  end
end
