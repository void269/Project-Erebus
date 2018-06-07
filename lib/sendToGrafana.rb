#!/usr/bin/env ruby

require 'rest-client'
require 'json'


class Send_To_Grafana
  def apicall(payload, url='http://10.0.1.81:8086/write?db=mydb')
    puts("Sending API call to #{url}")
    responce = RestClient.post(url, payload)
    return responce
  end
end

call = Send_to_Grafana.new()
call.apicall(payload, url)
