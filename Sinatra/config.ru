masterfile = File.open("/etc/Project-Erebus/master")
slavefile  = File.open("/etc/Project-Erebus/slave")

if masterfile
  require './runMaster.rb'
elsif slavefile
  require '/etc/Project-Erebus/Sinatra/runSlave.rb'
end

run MyApp
