$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require "spec_helper"
require "logging"

describe App_Logger do
  before :each do
    @logging = App_Logger.new
  end

  it "#should initialze instance variables" do
    #logging = App_Logger.new
    @logging.loglongname.should == "/etc/Project-Erebus/logs/runtime.log"
  end
end
