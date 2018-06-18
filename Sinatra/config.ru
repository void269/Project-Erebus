begin
  masterfile = File.open("/etc/Project-Erebus/master")
rescue
  slavefile  = File.open("/etc/Project-Erebus/slave")
end

if masterfile
  require './runMaster.rb'
elsif slavefile
  require '/etc/Project-Erebus/Sinatra/runSlave.rb'
end

run MyApp
