require 'sinatra/base'
require '/etc/Project-Erebus/lib/gatherData.rb'

class MyApp < Sinatra::Base
  get '/' do
    result = Gatherdata.new
    result
  end
end

puts "in the slave file"
