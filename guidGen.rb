slavefile  = File.open("./slave")

if slavefile
  puts "This is a Slave"
  if File.zero?(slavefile)
    puts "Generating UUID for first run!"
    require 'securerandom'
    require 'socket'

    ip_addrs = Socket.ip_address_list
    ip_addrs.each do |i|
      if i.ip_address.exclude?('127') || i.ip_address.exclude?(':')
        ip =  i.ip_address
        break
      end
    end
    uuid = SecureRandom.uuid
    slavefile.write("#{uuid},#{ip}")
  else
    uuid = slavefile.split(',')[0]
    puts "This Slave already has a UUID of #{uuid}"
    puts "Nothing to do, exiting"
  end
end
