$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'logging'
require 'rest-client'
require 'json'


class Send_To_Grafana
  def initialize(payload = "", url = 'http://10.0.1.81:8086/write?db=mydb', header = "", logger = App_Logger.new)
    @log = logger
    @url = url
    @payload = payload
    @header = header
  end

  def send_panal_metrics

  end

  def apicall(method = "get", url = nil, payload = "", header = "")

    puts("Sending API call to #{@url} with payload of #{@payload[0]}")
    responce = RestClient.post(@url, @payload[0])
    puts("#{responce}")
  end

  def failure
    puts "Failed to make API call to #{@url}"
  end
end

call = Send_To_Grafana.new()
call.apicall(@payload)
