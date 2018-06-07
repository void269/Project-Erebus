#!/usr/bin/env ruby

require 'rest-client'
require 'json'


class Send_To_Grafana
  def initialize()
    @url = 'http://10.0.1.81:8086/write?db=mydb'
    @payload = payload
  end

  def apicall(payload)
    puts("Sending API call to #{url}")
    responce = RestClient.post(@url, @payload)
    return responce
  end

  def failure
    puts "Failed to make API call to #{@url}"
  end
end

call = Send_To_Grafana.new(payload)
call.apicall(@payload)
