$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'uuidGen'
require "fileutils"
require 'rest-client'
require 'json'
require 'logging'

class ManageSlave
  def add_new_slave(ip = nil)
    return "Error missing IP Address" if ip == nil
    ### Add new slave to ansible inventory file ###
    insert_to_file(ip, "[slave]", "/etc/Project-Erebus/ansible/inventory")
    ### run Start.sh to initiate ansible on all nodes ###
    `sudo /etc/Project-Erebus/start.sh`
    ### generate guid for slave ###
    success, state, result = UUIDGen.new
  end

  def insert_to_file(insert_text, after_line, file_path)
    temp_file_path = "#{file_path}_new"
    tempfile=File.open(temp_file_path, 'w')
    f=File.new(file_path)
    f.each do |line|
      tempfile<<line
      if line == "#{after_line}\n"
        tempfile << "#{insert_text}\n"
      end
    end
    f.close
    tempfile.close

    FileUtils.mv(temp_file_path, file_path)
  end
end

#ManageSlave.new.add_new_slave(ip)
