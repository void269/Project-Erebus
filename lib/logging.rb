require 'logger'
require 'fileutils'

class App_Logger
  def initialize
    @logpath = "/etc/Project-Erebus/logs"
    @logfilename = "runtime.log"
    @loglongname = "#{@logpath}/#{@logfilename}"
    FileUtils.mkdir_p @logpath
    File.new(@loglongname, "w") unless File.exist?(@loglongname)
    @logfile = File.open("#{@logpath}/#{@logfilename}", "w")
  end

  def main(log_level = "INFO", text = nil, app_name = "Erebus")
    time = Time.new.utc.strftime('%m-%d-%y %H:%M:%S.%L%L')
    @logfile.write("\n")
    @logfile.write("#{time} -> #{log_level.upcase} - [#{app_name}] #{text}")
  end
end
