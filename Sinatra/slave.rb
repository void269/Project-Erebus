require 'sinatra/base'
require_relative 'gatherData'

class MyApp < Sinatra::Base
  get '/' do
     #THIS IS THE PROBLEM!!!!!!!!
    result = Gatherdata.new
    result
    'testing'
  end
end
