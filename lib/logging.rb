require 'logger'
require 'fileutils'

class App_Logger
  attr_accessor :loglongname
  def initialize(logpath = "/etc/Project-Erebus/logs", logfilename = "runtime.log")
    @loglongname = "#{logpath}/#{logfilename}"
    FileUtils.mkdir_p logpath
    File.new(@loglongname, "w") unless File.exist?(@loglongname)
    @logfile = File.open(logfile, "a")
  end

  def main(log_level = "INFO", text = nil, app_name = "Erebus", logfile = @logfile)
    time = Time.new.utc.strftime('%m-%d-%y %H:%M:%S.%L%L')
    logfile.write("#{time} -> #{log_level.upcase} - [#{app_name}] #{text}")
    logfile.write("\n")
    logfile.close
  end
end
