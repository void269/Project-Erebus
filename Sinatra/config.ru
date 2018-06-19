begin
  masterfile = File.open("/etc/Project-Erebus/master")
rescue
  slavefile  = File.open("/etc/Project-Erebus/slave")
end

if masterfile
  require './master.rb'
elsif slavefile
  require './slave.rb'
end

run MyApp.new :bind => '10.0.1.133'
