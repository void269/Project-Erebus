require 'sinatra'
require 'gatherData.rb'

get '/solarpanel-data' do
  result = Gatherdata.new
  return result
end
