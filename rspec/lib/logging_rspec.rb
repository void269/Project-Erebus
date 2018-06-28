$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require "spec_helper"
require "logging"

describe App_Logger do
  it "#should write to a log file" do
    @logging = App_Logger.new #.main(:info, "rspec test")
    #@logging.loglongname.should == "/etc/Project-Erebus/logs/runtime.log"
  end
end
