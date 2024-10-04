#!/bin/bash

dnf install epel-release -y
dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm -y
dnf update -y

dnf config-manager --set-enabled remi-safe

dnf module reset php -y
dnf module install php:remi-8.4 -y
dnf install php-intl php-mbstring php-cli php-xml php-mysqlnd php-gd php-curl php-zip php-json php-imagick php-simplexml
