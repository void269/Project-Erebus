$LOAD_PATH.unshift('/etc/Project-Erebus/lib')

require 'logging'
require 'sinatra/base'
require 'gatherData'
log = App_Logger.new

class MyApp < Sinatra::Base
  get '/' do
    gather = Gatherdata.new
    result = gather.getdata_ina219
    log.main("info", "API call to '/' returned #{result}")
    result
  end
end
