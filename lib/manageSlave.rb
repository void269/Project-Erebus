$LOAD_PATH.unshift('/etc/Project-Erebus/lib')
require 'uuidmgmt'
require "fileutils"
require 'rest-client'
require 'json'
require 'logging'

class ManageSlave
  def initialize(logger = App_Logger.new)
    @log = logger
    @master = "/etc/erebus/master"
  end

  def add_new_slave(ip = nil)
    @log.write(:info, "Evaluating slave")
    if ip == nil
      @log.write(:error, "missing IP added when atempting to add slave")
      return "Error missing IP Address"
    end

    @log.write(:info, "Checking if slave already exists")
    ### generate guid for slave ###
    result = RestClient.post("http://#{ip}/uuidgen", nil)
    @log.write(:info, "result is: #{result.body}")
    slaveuuid = result['uuid']
    @log.write(:info, "slaveuuid is: #{slaveuuid}")
    existing = File.open(@master).grep(/#{slaveuuid.split(',')[0]}/)[0].chomp
    @log.write(:info, "existing is: #{existing}")
    if existing.size > 0 ####################################################################---> is NOT new slave
      @log.write(:info, "UUID found, slave already exists")
      if existing.split(',')[1] == ip ###################################################---> ip has NOT changed
        @log.write(:info, "IP is the same in master file, doing nothing")
      else ##################################################################################---> ip has changed
        @log.write(:info, "IP is different than whats in master file!")
        # replacing in master file
        replace_in_file(slaveuuid.split(',')[0], slaveuuid, @master)
        # replacing in ansible inventory file
        ansible_input = "#{slaveuuid.split(',')[1]} uuid=#{slaveuuid.split(',')[0]}"
        replace_in_file(slaveuuid.split(',')[0], ansible_input, "/etc/Project-Erebus/ansible/inventory")
      end
    else ########################################################################################---> is new slave
      @log.write(:info, "Adding new slave #{ip}")
      ### add to master file
      insert_to_file(slaveuuid, nil, @master)
      ### Add new slave to ansible inventory file ###
      ansible_input = "#{slaveuuid.split(',')[1]} uuid=#{slaveuuid.split(',')[0]}"
      insert_to_file(ansible_input, "[slave]", "/etc/Project-Erebus/ansible/inventory")
    end
    #`sudo /etc/Project-Erebus/start.sh`  ############### NEEDS SSH PASS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  end

  def insert_to_file(insert_text, after_line = nil, file_path)
    @log.write(:info, "insterting #{instert_text} after line #{after_line} in file #{file_path}")
    if after_line == nil
      File.open(file_path, "a") do |f|
        f.write(insert_text)
      end
    else
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
      @log.write(:info, "File inser complete")
    end
  end

  def replace_in_file(oldline, newline, file_path)
    @log.write(:info, "Replacing *#{oldline}* with \"#{newline}\" in file #{file_path}")
    contents = File.read(file_path)
    new_contents = contents.gsub(/#{oldline}/, newline)
    File.open(file_path, "w") do |f|
      f.write(new_contents)
    end
    @log.write(:info, "completed line replace")
  end
end

#ManageSlave.new.add_new_slave(ip)
