#!/usr/bin/env ruby

class Gatherdata
  def initialize
    @milliamp_measure = 0.03
  end

  def getdata_ina219
    result = `python /etc/Project-Erebus/bin/return_ina219.py 0.03`
    result = "0,0,0" if result == nil || result == ""
    return result
  end
end
