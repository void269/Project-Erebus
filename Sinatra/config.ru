$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'logging'

log = App_Logger.new

if File.file?("/etc/Project-Erebus/master")
  require './master.rb'
  run MyApp.new
elsif File.file?("/etc/Project-Erebus/slave")
  require './slave.rb'
  run MyApp.new
else
  puts "ERROR - No master/slave file found! Nothing to do, exiting Sinatra with error"
  log.main("error", "No master/slave file found!")
end
