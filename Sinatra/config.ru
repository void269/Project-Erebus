begin
  masterfile = File.open("/etc/Project-Erebus/master")
rescue
  slavefile  = File.open("/etc/Project-Erebus/slave")
end

if masterfile
  require './runMaster.rb'
elsif slavefile
  require './runSlave.rb'
end

run MyApp.new
