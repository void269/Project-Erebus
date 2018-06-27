describe App_Logger do
  it "#should write to a log file" do
    App_Logger.new.main(:info, "rspec test")
  end
end
