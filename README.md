AbuseIO 5.0 Ansible Installer

Overview
- Automates installation on Ubuntu 24.04 LTS following AbuseIO docs.
- Uses reusable roles where possible and adds minimal custom roles.
- Focuses on security hardening and idempotent behavior.

Quick start
- Install dependencies: `ansible-galaxy install -r requirements.yml`
- Update `inventory/hosts` and `group_vars/settings.yml` for your domain.
- Run: `ansible-playbook -i inventory/hosts playbook.yml -vv`

What’s included
- Firewall (UFW): default deny incoming, allow SMTP/HTTP/HTTPS, restrict SSH.
- PHP 8.4 via Ondřej PPA, Apache, MariaDB, Postfix.
- Certbot + Apache plugin for Let’s Encrypt.
- PHP mailparse built from source and enabled.
- AbuseIO app clone, permissions, and Composer install.

Security notes
- UFW restricts SSH to `ssh_admin_cidr` only.
- MariaDB root password required; secure-installation is enabled.
- Composer runs as `www-data` to avoid root execution.
- Service environment warnings for MariaDB are silenced via a systemd drop-in.