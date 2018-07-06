$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'logging'
require 'securerandom'
require 'socket'

class UUID
  def initialize
    @log = App_Logger.new
    @log.write(:info, "this is a test")
    if File.exist?("/etc/erebus/slave")
      uuid_gen_slave
    end

    if File.exist?("/etc/erebus/master")
      uuid_gen_master
    end
  end

  def uuid_gen_slave
    if file_exist?("/etc/erebus/slave")
      @log.write(:INFO, "slave file exists")
      if file_empty?("/etc/erebus/slave")
        @log.write(:INFO, "Starting UUID Gen for slave")
        ip = get_local_ip
        @log.write(:INFO, "IP addr found -> #{ip}")
        uuid = SecureRandom.uuid
        @log.write(:INFO, "UUID generated -> #{uuid}")
        @log.write(:INFO, "in uuid buld")
        @output = "#{uuid},#{ip}"
        File.open("/etc/erebus/slave", 'w') do |f|
          f.write(@output)
          f.close
        end
        @log.write(:INFO, "before return")
        return {:success => true, :state => "new", :output => @output}
        @log.write(:INFO, "after return")
      else
        @log.write(:WARN, "Slave file already contains data, doing nothing!")
        exist = File.open("/etc/erebus/slave", 'r')
        return {:success => true, :state => "existing", :output => exist.read}
      end
    else
      @log.write(:error, "missing slave file, cannot proceed!")
      return {:success => false, :state => "missing slave file", :output => ""}
    end
  end

  def uuid_gen_master
    return {:success => false, :state => "node is master", :output => ""}
  end

  def file_empty?(file_path)
    return true if File.zero?(file_path)
  end

  def file_exist?(file_path)
    return true if File.exists?(file_path)
  end

  def get_local_ip
    ip_addrs = Socket.ip_address_list
    all_ips = ip_addrs.reject {|i| i.ip_address =~ /127/ || i.ip_address =~ /:/}
    ip = all_ips[0].ip_address
    return ip
  end
end
