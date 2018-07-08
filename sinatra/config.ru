$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'logging'

log = App_Logger.new

if File.file?("/etc/erebus/master")
  require './master.rb'
  run MyApp.new
elsif File.file?("/etc/erebus/slave")
  require './slave.rb'
  run MyApp.new
else
  puts "ERROR - No master/slave file found! Nothing to do, exiting Sinatra with error"
  log.write("error", "No master/slave file found!")
end
