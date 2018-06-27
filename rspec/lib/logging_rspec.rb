require "spec_helper"

describe App_Logger do
  it "#should write to a log file" do
    logging = App_Logger.new #.main(:info, "rspec test")
    logging.logpath.should == "/etc/Project-Erebus/logs"
    
  end
end
