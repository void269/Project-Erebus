require "fileutils"

class ManageSlave
  def add_new_slave(ip = nil)
    return "Error missing IP Address" if ip == nil
    hosts_file = File.open("/etc/Project-Erebus/ansible/hosts", 'w')
    hosts_file.
  end
end
