$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'sinatra/base'
require 'gatherData'

class MyApp < Sinatra::Base
  get '/' do
    gather = Gatherdata.new
    result = gather.getdata_ina219
    result
  end
end
