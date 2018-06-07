#!/usr/bin/env ruby

require 'rest-client'
require 'json'


class Send_To_Grafana
  def initialize()
    @url = 'http://10.0.1.81:8086/write?db=mydb'
    @payload = ARGV
  end

  def apicall(payload)
    puts("Sending API call to #{@url} with payload of #{@payload[0]}")
    responce = RestClient.post(@url, @payload[0])
    puts(responce)
  end

  def failure
    puts "Failed to make API call to #{@url}"
  end
end

call = Send_To_Grafana.new()
call.apicall(@payload)
