require "fileutils"

class ManageSlave
  def add_new_slave(ip = nil)
    return "Error missing IP Address" if ip == nil
    insert_to_file(ip, "[slave]", "/etc/Project-Erebus/ansible/inventory")
    `./etc/Project-Erebus/start.sh`
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
