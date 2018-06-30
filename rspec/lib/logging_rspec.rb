$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require "spec_helper"
require "logging"

describe App_Logger do
  before :each do
    @logging = App_Logger.new
  end

  it "#should initialze instance variables" do
    #logging = App_Logger.new
    expect(@logging.loglongname).to eq("/etc/Project-Erebus/logs/runtime.log")
  end

  it "#should write an INFO log entry" do
    File.stub(:write)
    @logging.main(:info, "this is a test")
    expect(File).to have_recieved(:write).with(:info, "this is a test").once
  end
end
