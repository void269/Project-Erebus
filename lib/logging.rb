require 'logger'
require 'fileutils'

class App_Logger
  def initialize
    @logpath = "/etc/Project-Erebus/logs"
    @logfilename = "runtime.log"
    fileutils.mkdir_p @logpath
    @logfile = File.open("#{@logpath}/#{@logfilename}", "w")
  end

  def main(log_level = "INFO", text = nil, app_name = "Erebus")
    time = Time.new.utc.strftime('%m-%d-%y %H:%M:%S.%L%L')
    @logfile.write("\n")
    @logfile.write("#{time} -> #{log_level.upcase} - [#{app_name}] #{text}")
  end
end
