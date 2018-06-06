require 'rest-client'
require 'json'


class send_to_Grafana
  def apicall(url='http://10.0.1.81:8086/write?db=mydb', payload)
    puts("Sending API call to #{url}")
    responce = RestClient.post(url, payload)
    return responce
  end
end

send_to_Grafana.new
