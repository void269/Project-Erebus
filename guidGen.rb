slavefile  = File.open("./slave")

if slavefile
  puts "This is a Slave"
  if File.zero?(slavefile)
    puts "Generating UUID for first run!"
    require 'securerandom'
    require 'socket'

    ip_addrs = Socket.ip_address_list
    allips = ip_addrs.reject {|i| i.ip_address =~ /127/ || i.ip_address =~ /:/}
    ip = allips[0].ip_address

    uuid = SecureRandom.uuid
    slavefile.write("#{uuid},#{ip}")
  else
    uuid = slavefile.split(',')[0]
    puts "This Slave already has a UUID of #{uuid}"
    puts "Nothing to do, exiting"
  end
end
