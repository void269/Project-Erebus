require 'sinatra/base'

class MyApp < Sinatra::Base
  get '/' do
    require '/etc/Project-Erebus/lib/gatherData.rb' #THIS IS THE PROBLEM!!!!!!!!
    result = Gatherdata.new
    result
    'testing'
  end
end

puts "in the slave file"
