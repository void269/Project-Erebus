read -p "Must be run on Master! Press enter to continue"
apt install ansible sshpass git -y
sed -i 's/#host_key_checking = False/host_key_checking = False/' /etc/ansible/ansible.cfg
if [ ! -d "/etc/Project-Erebus" ]; then
  git clone https://github.com/void269/Project-Erebus.git /etc
else
  git -C /etc/Project-Erebus/ pull
fi
if [ ! -f "/etc/erebus/inventory" ]; then
  cp /etc/Project-Erebus/ansible/inventory.template /etc/erebus/inventory
  ip=ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
  sed -i "s/masterip/$ip/" /etc/erebus/inventory
fi
ansible-playbook -i /etc/erebus/inventory /etc/Project-Erebus/ansible/nodeSetup.yml --ask-pass
