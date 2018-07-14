$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'manageSlave'
require 'logging'
require 'sinatra/base'
require 'gatherData'
require 'uuidmgmt'
@log = App_Logger.new


class MyApp < Sinatra::Base
  get '/' do
    "hello"
  end

  put '/newslave' do
    values = JSON.parse(request.body.read)
    @log.write(:info, "values are: #{values}")
  end
end
