#!/bin/bash

dnf -y update
dnf -y install epel-release
dnf -y --assumeyes install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
dnf -y --assumeyes module reset php
dnf -y --assumeyes module install php:remi-8.4
dnf -y --assumeyes install php-intl php-mbstring php-cli php-xml php-mysqlnd php-gd php-curl php-zip php-json php-imagick php-simplexml
