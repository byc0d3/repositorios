#!/bin/bash

# Update all packages
dnf -y update

# Install httpd
dnf -y install httpd

# Enable and start httpd
systemctl enable httpd --now

# Install necessary packages and PHP modules
dnf -y install epel-release
dnf -y --assumeyes install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
dnf -y --assumeyes module reset php
dnf -y --assumeyes module install php:remi-8.3
dnf -y --assumeyes install php-intl php-mbstring php-cli php-xml php-mysqlnd php-gd php-curl php-zip php-json php-imagick php-simplexml

# Restart httpd to apply changes
systemctl restart httpd

# Install Composer
wget https://getcomposer.org/installer -O composer-installer.php
php composer-installer.php --filename=composer --install-dir=/usr/local/bin

# Restart httpd again
systemctl restart httpd

# Setup MariaDB repository and install MariaDB
curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash
dnf -y --assumeyes install mariadb-server mariadb

# Enable and start MariaDB
systemctl enable mariadb
systemctl start mariadb

echo "Script completado. Todos los servicios han sido instalados y configurados."
