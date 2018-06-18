masterfile = File.open(./master)
slavefile  = File.open(./slave)

if masterfile
  require './runMaster.rb'
elsif slavefile
  require '/etc/Project-Erebus/Sinatra/runSlave.rb'
end

run MyApp
