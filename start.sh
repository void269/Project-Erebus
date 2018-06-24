read -p "Must be run on Master! Press enter to continue"
apt install ansible sshpass git -y
sed -i 's/#host_key_checking = False/host_key_checking = False/' /etc/ansible/ansible.cfg
if [ ! -d "/etc/Project-Erebus"]; then
  git clone https://github.com/void269/Project-Erebus.git /etc
else
  git -C /etc/Project-Erebus/ pull
fi
ansible-playbook -i hosts nodeSetup.yml --ask-pass
