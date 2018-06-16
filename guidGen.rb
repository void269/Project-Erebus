@slavefile  = File.open("/etc/Project-Erebus/slave", 'w')

if @slavefile
  puts "This is a Slave"
  puts "file size is: #{@slavefile.size}"
  if @slavefile.size == 0
    puts "Generating UUID for first run!"
    require 'securerandom'
    require 'socket'

    ip_addrs = Socket.ip_address_list
    all_ips = ip_addrs.reject {|i| i.ip_address =~ /127/ || i.ip_address =~ /:/}
    ip = all_ips[0].ip_address

    uuid = SecureRandom.uuid
    @slavefile.write("#{uuid},#{ip}")
  else
    uuid = @slavefile.split(',')[0]
    puts "This Slave already has a UUID of #{uuid}"
    puts "Nothing to do, exiting"
  end
else
  puts "ERROR: Slave file not found!"
end
