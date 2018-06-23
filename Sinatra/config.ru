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

#require '/etc/Project-Erebus/Sinatra/slave.rb'
run MyApp.new
