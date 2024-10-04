#!/bin/bash

wget https://getcomposer.org/installer -O composer-installer.php
php composer-installer.php --filename=composer --install-dir=/usr/local/bin
rm -rf composer-installer.php
systemctl restart httpd
