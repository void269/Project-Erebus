$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'logging'
require 'securerandom'
require 'socket'

class UUID
  def initialize(logger = App_Logger.new)
    @log = logger
    @slave_path = "/etc/erebus/slave"
    @master_path = "/etc/erebus/master"
  end

  def main
    if File.exist?(@slave_path)
      uuid_gen_slave
    elsif File.exist?(@master_path)
      uuid_gen_master
    else
      @log.write(:error, "missing slave/master file, cannot proceed!")
      return {:success => false, :state => "missing slave/master file", :output => ""}
    end
  end

  def uuid_gen_slave
    ip = get_local_ip
    if file_empty?(@slave_path) ##########################################################---> slave file is empty
      @log.write(:INFO, "Starting UUID Gen for slave")
      @log.write(:INFO, "IP addr found -> #{ip}")
      uuid = SecureRandom.uuid
      @log.write(:INFO, "UUID generated -> #{uuid}")
      @output = "#{uuid},#{ip}"
      File.open(@slave_path, 'w') do |f|
        f.write("#{@output}\n")
        f.close
      end
      return {:success => true, :state => "new", :output => @output}
    else #############################################################################---> slave file is NOT empty
      @log.write(:WARN, "Slave file already contains data, checking if IP has changed")
      exist = File.readlines(@slave_path).grep(/#{ip}/)[0]
      if exist != nil ##################################################################---> IP did NOT change
        @log.write(:INFO, "IP address has not changed, doing nothing")
        return {:success => true, :state => "existing", :output => exist}
      else ###################################################################################---> IP did change
        @log.write(:INFO, "IP address has changed, updating slave file")
        uuid = File.readlines(@slave_path)[0].split(',')[0]
        uuid_ip = "#{uuid},#{ip}"
        replace_line(uuid, uuid_ip, @slave_path)
        return {:success => true, :state => "updated", :output => uuid_ip}
      end
    end
  end

  def uuid_gen_master
    @log.write(:INFO, "master file exists")
    return {:success => false, :state => "master", :output => ""}
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
    @log.write("IP address found: #{ip}")
    return ip
  end

  def replace_string(oldline, newline, file_path)
    @log.write(:info, "Replacing *#{oldline}* with \"#{newline}\" in file #{file_path}")
    contents = File.read(file_path)
    new_contents = contents.gsub(/#{oldline}/, newline)
    File.open(file_path, "w") do |f|
      f.write(new_contents)
    end
    @log.write(:info, "completed line replace")
  end

  def replace_line(match_string, new_line, file_path)
    contents = File.read(file_path)
    new_contents = ""
    contents.each_line do |line|
      if line.match(/#{match_string}/)
        new_contents << "#{new_line}\n"
      else
        new_contents << line
      end
    end
    file = File.open(file_path, "w")
    file.write(new_contents)
    file.close
  end
end
