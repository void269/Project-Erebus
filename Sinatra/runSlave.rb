require 'sinatra'
require 'gatherData'

class MyApp < sinatra::Base
  get '/solarpanel-data' do
    result = Gatherdata.new
    return result
  end
end
