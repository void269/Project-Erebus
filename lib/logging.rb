require 'logger'
require 'fileutils'

class App_Logger
  def initialize
    @logpath = /etc/Project-Erebus/logs
    @logfilename = runtime.log
    fileutils.mkdir_p @logpath
    
  end

  def check_logdir

  end

  def check_file

  end
end
