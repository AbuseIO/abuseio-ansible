this playbook assume that you have:

- A clean Ubuntu 16.04 installation
- Networking with resolving, with IPv4 and IPv6 address
- A hostname pointing to the same IPv4 and IPv6 address
- Set the variables in vars/abuseio.yml
- Didn't change anything else

TODO:
- set deps throughout roles
- certbot to --agree-tos with abuse@ configured address & certbot to install certificates

install augeas-lenses libaugeas0 libexpat1-dev libffi-dev libpython-dev libpython2.7 libpython2.7-dev python-dev python-pip-whl python-virtualenv python2.7-dev python3-virtualenv virtualenv
and use --no-bootstrap to save time

/opt/certbot/certbot-auto register --agree-tos --email abuse@isp.local -n
/opt/certbot/certbot-auto --apache -d abuseio.isp.local -n

- postfix set FQDN
- postfix create alias + notifier mapping
- postfix to use SSL cert
- apache hardening
- install systemd files
- install logrotate
- create admin user
- create cronjobs
- setup local resolver
- add fail2ban just in case
