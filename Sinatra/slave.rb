require 'sinatra/base'
require '/etc/Project-Erebus/lib/gatherData.rb'

class MyApp < sinatra::Base
  get '/solarpanel-data' do
    result = Gatherdata.new
    result
  end
end
