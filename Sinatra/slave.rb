require 'sinatra/base'
require '/etc/Project-Erebus/lib/gatherData.rb'

class MyApp < sinatra::Base
  get '/' do
    #result = Gatherdata.new
    #result
    "testing"
  end
end
