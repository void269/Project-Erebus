require 'sinatra/base'
require '/etc/Project-Erebus/lib/gatherData'

class MyApp < Sinatra::Base
  get '/' do
     #THIS IS THE PROBLEM!!!!!!!!
    result = Gatherdata.new
    result
    'testing'
  end
end
