$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'logging'

log = App_Logger.new
puts "made it here"
if File.file?("/etc/Project-Erebus/master")
  require './master.rb'
  run MyApp.new
elsif File.file?("/etc/Project-Erebus/slave")
  require './slave.rb'
  run MyApp.new
else
  puts "made it there"
  log.main("error", "No master/slave file found!")
end
