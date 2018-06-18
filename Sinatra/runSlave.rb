require 'sinatra'
require 'gatherData'

get '/solarpanel-data' do
  result = Gatherdata.new
  return result
end
