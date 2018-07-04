$LOAD_PATH.unshift('/etc/Project-Erebus/lib')

require 'logging'
require 'sinatra/base'
require 'gatherData'
@log = App_Logger.new

class MyApp < Sinatra::Base
  get '/' do
    "hello"
  end

  get '/paneldata' do
    gather = Gatherdata.new
    result = gather.getdata_ina219
    @log.main("info", "API call to '/' returned #{result}")
    result
  end

  post '/uuidgen' do
    uuid = UUID.new
    success, state, result = uuid.uuid_gen_slave
    if success == true
      content_type :json
      payload = {:state => state, :uuid => result}.to_json
      return payload
    end
  end
end
