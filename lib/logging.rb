require 'logger'
require 'fileutils'

class App_Logger
  attr_accessor :loglongname
  def initialize(logpath = "/etc/erebus/logs", logfilename = "runtime.log")
    @loglongname = "#{logpath}/#{logfilename}"
    FileUtils.mkdir_p logpath
    File.new(@loglongname, "w") unless File.exist?(@loglongname)
    @logfile = File.open(@loglongname, "a")
  end

  def write(log_level = "INFO", text = nil, app_name = "Erebus", log = @logfile)
    log_level = "WARN" if log_level.upcase == "WARNING"
    log_level = "OTHER" unless log_level.upcase == "INFO" ||
      log_level.upcase == "WARN" ||
      log_level.upcase == "ERROR" ||
      log_level.upcase == :INFO ||
      log_level.upcase == :WARN ||
      log_level.upcase == :ERROR
    time = Time.new.utc.strftime('%m-%d-%y %H:%M:%S.%L%L')
    log.write("#{time} -> #{log_level.upcase} - [#{app_name}] #{text}\n")
    log.flush
    log.close
  end
end
