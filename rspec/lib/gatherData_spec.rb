$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require "rspec"
require "gatherData"

describe Gatherdata do
  before :each do
    @gatherdata = Gatherdata.new
  end

  it "#should return something" do
    expect(@gatherdata.getdata_ina219).to match(/,/)
  end
end
