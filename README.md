this playbook assume that you have:

- A clean Ubuntu 16.04 installation
- Networking with resolving, with IPv4 and IPv6 address
- Set the variables in vars/abuseio.yml
- Didn't change anything else

TODO:
- postfix set FQDN
- postfix create alias + notifier mapping
- add local user
- change mysql defaults
- clone abuseio + composer installer
- set permissions
- install systemd files
- install logrotate
- create .env file
- create admin user
- create cronjobs
- setup local resolver
