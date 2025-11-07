# AbuseIO 5.0 Ansible Installer

## Overview
Automates installation on Ubuntu 24.04 LTS following AbuseIO docs.

This should work :) However this is a complete revamp from the old (broken) version, reusing existing roles where possible and keeping security in mind. 
If there are issues, please provide full ansible output and report it.

This version is not compatible with previous AbuseIO versions (e.g. 4.3). If you need to install an older version (which you should not do), you can look at tag 4.3 which was the previous version.

## Quick start

- Collect playback and install dependancies
```
git clone https://github.com/AbuseIO/abuseio-ansible.git
cd abuseio-ansible 
ansible-galaxy install -r requirements.yml
```

- Update `inventory/hosts` with your target host (remote)
- Update `group_vars/settings.yml` with you base settings
- [Advanced users only] Update `group_vars/defaults.yml`
- Run: `ansible-playbook -i inventory/hosts playbook.yml`

## What’s included
- Firewall (UFW): default deny incoming, allow SMTP/HTTP/HTTPS, restrict SSH to configured admin CIDR's.
- Uses latest PHP 8.4, Apache, MariaDB, Postfix.
- Certbot + Apache plugin for Let’s Encrypt, with automated certificate request
- PHP mailparse built from source and enabled.
- AbuseIO 5.0, preconfigured with admin user from Ansible configuration
- OS/Application hardening with Lunis validation

