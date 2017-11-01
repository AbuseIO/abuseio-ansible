#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo ***
echo * Magic is starting
echo ***
apt-get update
apt-get install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible git python-netaddr python-dnspython
git clone https://github.com/AbuseIO/abuseio-ansible.git /opt/abuseio-ansible
cd /opt/abuseio-ansible
echo '***'
echo '* edit the file /opt/abuseio-ansible/vars/abuseio.yml and take care of the' 
echo '* values. Make sure your hostname is valid and has a A/AAAA record which is'
echo '* bound to this machine. Once completed you can complete the install by running:'
echo '* '
echo '* root@ubuntu:/opt/abuseio-ansible# ansible-playbook -i hosts playbook.yml'
echo '*'
echo '* PLEASE NOTE: The entire playbook can run over 30 minutes, so be patient!'
echo '* '
echo '* Ran into problems? pastebin your entire output and submit an issue'
echo '***'

