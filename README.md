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

- Update `group_vars/settings.yml` with your base settings
- [Advanced users only] Update `group_vars/defaults.yml`
- Choose one of the run modes below.

### Run on localhost

Option A — use an inventory file:

1) Create `inventory/hosts` with:

```
[abuseio]
localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python3
```

2) Run:

```
ansible-playbook -i inventory/hosts playbook.yml
```

Option B — no inventory file (inline localhost inventory):

```
ansible-playbook -i 'localhost,' -c local playbook.yml
```

Notes for localhost:
- OS: tested on Ubuntu 24.04 LTS; must have `apt`, `python3`, and sudo/root.
- Certificates: Let’s Encrypt requires a public, DNS-resolvable hostname. For offline/local testing, skip certificate tasks:
  - `ansible-playbook -i 'localhost,' -c local playbook.yml --skip-tags certbot,tls`
- Hostname: set `abuseio_hostname` in `group_vars/settings.yml` to your domain. For local-only testing, you can use a placeholder (e.g. `demo.local`), but certificate issuance will be skipped or must be disabled as above.
- Privileges: run as a user with sudo or root; many tasks (packages, services) require elevated privileges.

### Run against a remote host

1) Create `inventory/hosts` with your target host:

```
[abuseio]
your.remote.host
```

2) Run:

```
ansible-playbook -i inventory/hosts playbook.yml
```

## What’s included
- Firewall (UFW): default deny incoming, allow SMTP/HTTP/HTTPS, restrict SSH to configured admin CIDR's.
- Uses latest PHP 8.4, Apache, MariaDB, Postfix.
- Certbot + Apache plugin for Let’s Encrypt, with automated certificate request
- PHP mailparse built from source and enabled.
- AbuseIO 5.0, preconfigured with admin user from Ansible configuration
- OS/Application hardening with Lunis validation

