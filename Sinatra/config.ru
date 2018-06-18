masterfile = File.open(./master)
slavefile  = File.open(./slave)

if masterfile
  require './runMaster.rb'
elsif slavefile
  require './runSlave.rb'
end

run MyApp
