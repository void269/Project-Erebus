#begin
# masterfile = File.open("/etc/Project-Erebus/master", "r")
#rescue
# slavefile  = File.open("/etc/Project-Erebus/slave", "r")
#end

if File.file?("/etc/Project-Erebus/master")
  require './master.rb'
  run MyApp.new
elsif File.file?("/etc/Project-Erebus/slave")
  require './slave.rb'
  run MyApp.new
else
  puts "no slave/master file found!"
end

#require '/etc/Project-Erebus/Sinatra/slave.rb'
