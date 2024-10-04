#!/bin/bash

dnf config-manager --set-enabled powertools
dnf -y install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
dnf -y module reset php
dnf -y module install php:remi-8.4
dnf -y install php-intl php-mbstring php-cli php-xml php-mysqlnd php-gd php-curl php-zip php-json php-imagick php-simplexml
