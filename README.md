this playbook assume that you have:

- A clean Ubuntu 16.04 installation
- Networking with resolving, with IPv4 and IPv6 address
- Set the variables in vars/abuseio.yml
- Didn't change anything else

TODO:
- set deps throughout roles
- certbot to --agree-tos with abuse@ configured address
- certbot to install certificates
- postfix set FQDN
- postfix create alias + notifier mapping
- postfix to use SSL cert
- apache hardening
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
