if File.file?("/etc/Project-Erebus/master")
  require './master.rb'
  run MyApp.new
elsif File.file?("/etc/Project-Erebus/slave")
  require './slave.rb'
  run MyApp.new
else
  #Put an error output here!!!
end
