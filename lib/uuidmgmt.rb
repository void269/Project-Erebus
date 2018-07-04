$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'logging'
require 'securerandom'
require 'socket'

class UUID
  def initialize(log = App_Logger.new)
    @log = log
    if File.exist?("/etc/erebus.conf/slave")
      uuid_gen_slave
    end

    if File.exist?("/etc/erebus.conf/master")
      uuid_gen_master
    end
  end

  def uuid_gen_slave
    if File.exist?("/etc/erebus.conf/slave")
      slavefile  = File.open("/etc/erebus.conf/slave", 'w+')
      if slavefile.size == 0
        #@log.main(:INFO, "Starting UUID Gen for slave")
        ip_addrs = Socket.ip_address_list
        all_ips = ip_addrs.reject {|i| i.ip_address =~ /127/ || i.ip_address =~ /:/}
        ip = all_ips[0].ip_address
        #@log.main(:INFO, "IP addr found -> #{ip}")
        uuid = SecureRandom.uuid
        #@log.main(:INFO, "UUID generated -> #{uuid}")

        slavefile.write("#{uuid},#{ip}")
        slavefile.flush
        slavefile.close
        return true, "new", "#{uuid},#{ip}"
      else
        #@log.main(:WARN, "Slave file already contains data, doing nothing!")
        return true, "existing", "#{uuid},#{ip}"
      end
    else
      #@log.main(:error, "missing slave file, cannot proceed!")
      return false, "missing slave file", ""
    end
  end

  def uuid_gen_master
    return false, "is master", ""
  end
end
