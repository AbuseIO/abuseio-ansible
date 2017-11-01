# AbuseIO Ansible playbook

this playbook assume that you have:

- A system with 2 cores and 8 GB ram (16GB if you intend to run large collections)
- Minimal 20GB storage space for the OS and installation combined. Running a large network will require more storage, 50GB advised.
- A clean Ubuntu 16.04 installation
- Networking with resolving, with IPv4 and IPv6 address
- A hostname pointing to the same IPv4 and IPv6 address
- Set the variables in vars/abuseio.yml
- Didn't change anything else

Our playbook is based on the work of Jeff Geerling (geerlingguy) which saved me a LOT of time :)

# Note

The playbook basically does the entire installation manual for you. You should end up with a fully functional installation, but only
if you have set the variables correctly. The installation can take over 30 minutes depending on the speed of the system specifications.

# Oneshot installation

Oneshot is meant for people that don't know ansible or don't know how to install stuff. If you have the system ready you can just kick off the installation with:

    oneshot is: curl -s -L https://raw.githubusercontent.com/AbuseIO/abuseio-ansible/master/install.sh | bash

Then you get a messsage saying you must configure the variables and then start the playbook, so that would be:

    cd /opt/abuseio-ansible
    vi vars/abuseio.yml
    ansible-playbook -i hosts playbook.yml

It should send with a 'PLAY RECAP'. If it say's 'failed=0' on the end, your good and you should be able to browse the the hostname and login.

# Variables

Available variables are listed below, along with default values (see vars/abuseio.yml):

    abuseio_version: "4.1-gui"

Select the version to install, which should match a branch or tagged version.

    abuseio_basedir: "/opt/abuseio"

The path where AbuseIO should be installed to

    abuseio_hostname: "abuseio.isp.local"

The FQDN of the machine that is going to host AbuseIO. The FQDN *MUST* resolve to A/AAAA records which IP address must be bound on that same machine.
Else the installation will fail. If you don't have IPv6 yet, then its a great time to start!

    abuseio_admin_contact: "admin@isp.local"

The AbuseIO admin contact, which gets alerts on problems from AbuseIO, Certbot, etc. This e-mail adres *MUST* exists and accept e-mail, or the
installation *WILL* fail. 

    abuseio_abuse_contact: "abuse@isp.local"

The AbuseIO abuse contact, the address were complaints are send to for reference.

    abuseio_admin_user: "admin@isp.local"
    abuseio_admin_password: "changemetoo"

The AbuseIO admin user that will be created so you can login to the webgui. Be smart and *ACTUALLY CHANGE THE PASSWORD*

    abuseio_mysql_root_password: "changeme1"

The MySQL root password. MySQL will be installed which includes a default root account. Be smart and *ACTUALLY CHANGE THE PASSWORD*

    abuseio_mysql_database_name: "abuseio"
    abuseio_mysql_database_user: "abuseio_usr"
    abuseio_mysql_database_password: "changeme2"

The AbuseIO database and its user. The database with user will be created and configured within AbuseIO. Be smart and *ACTUALLY CHANGE THE PASSWORD*

    abuseio_trusted_v4_cidr: "0.0.0.0/0"
    abuseio_trusted_v6_cidr: "::0/0"

The playbook installs a firewall. You can leave these values if the whole internet is allowed to SSH to your server, however limiting to your admin
range would be a good idea. It allows you full access to the box. Only 80/443 will then publicly be open.

# TODO:

- set deps throughout roles
- certbot remove --test-cert for production
- postfix set FQDN
- postfix create alias + notifier mapping
- postfix to use SSL cert
- install systemd files
- install logrotate
- setup local resolver
- add fail2ban just in case
