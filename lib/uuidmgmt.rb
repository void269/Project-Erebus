$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'logging'
require 'securerandom'
require 'socket'

class UUID
  def initialize(logger = App_Logger.new)
    @log = logger
  end

  def main
    if File.exist?("/etc/erebus/slave")
      uuid_gen_slave
    elsif File.exist?("/etc/erebus/master")
      uuid_gen_master
    else
      @log.write(:error, "missing slave/master file, cannot proceed!")
      return {:success => false, :state => "missing slave/master file", :output => ""}
    end
  end

  def uuid_gen_slave
    @log.write(:INFO, "slave file exists")
    if file_empty?("/etc/erebus/slave")
      @log.write(:INFO, "Starting UUID Gen for slave")
      ip = get_local_ip
      @log.write(:INFO, "IP addr found -> #{ip}")
      uuid = SecureRandom.uuid
      @log.write(:INFO, "UUID generated -> #{uuid}")
      @output = "#{uuid},#{ip}"
      File.open("/etc/erebus/slave", 'w') do |f|
        f.write(@output)
        f.close
      end
      return {:success => true, :state => "new", :output => @output}
    else
      @log.write(:WARN, "Slave file already contains data, doing nothing!")
      exist = File.open("/etc/erebus/slave", 'r')
      return {:success => true, :state => "existing", :output => exist.read}
    end
  end

  def uuid_gen_master
    @log.write(:INFO, "master file exists")
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
