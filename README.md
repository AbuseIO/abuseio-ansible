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

# Changes
- Due to automation, the apache/postfix configurations are slightly different.

# TODO
- Fix mysql root user change password, its duplicate

# Security - apply or explain policy
The following audit / scanners were used for testing a server deployed by this Ansible playback:

- [Qualys SSL Labs](https://www.ssllabs.com/ssltest/), Score A+
- [Mozilla Observatory](https://observatory.mozilla.org/), Score B
- [ImmuniWeb](https://www.immuniweb.com/), Score A
- [lynis](https://cisofy.com/lynis/), Score 84/100

Audits report the following issues:

- Apache/TLS Key exchange does not pass 'post-quantum confidentiality' on key exchange and certificate chain. At this time we believe that the Letsencrypt defaults are sufficient.
- Apache/TLS Key exchange has TLS 1.2 enabled in a order, whereas  'post-quantum confidentiality' recommends to only use TLS 1.2 as a fallback. At this time we believe that the Letsencrypt defaults are sufficient.
- Apache/TLS 1.2 uses TLS_CHACHA20_POLY1305_SHA256 incorrectly. We use Letsencrypt defaults, which provides a strong an balanced key set. Therefor we believe this risk is negligible.
- TLS certificate lacks OCSP revocation information. We use a free Letsencrypt certificate, which does not provide OCSP revocation information. Letsencrypt has a CRL which provides the same features for revocation as OCSP. There is no risk on a security, and we believe this check is outdated.
- Apache/Headers are missing CSP-policy. Due to inline script loading, it would be the most unrestrictive policy, thus it makes no sense to explicitly list allow any, which is default. However, we believe that the risk is negligible.
