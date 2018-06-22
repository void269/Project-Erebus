$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'sinatra/base'
require_relative 'gatherData.'

class MyApp < Sinatra::Base
  get '/' do
    gather = Gatherdata.new
    result = gather.getdata_ina219
    puts result
  end
end
