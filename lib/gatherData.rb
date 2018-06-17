#!/usr/bin/env ruby


class Gatherdata
  def getdata_ina219
    result = exec("python ./return_ina219.py 0.03")
    puts "INA219 return is: #{result}"
  end
end
