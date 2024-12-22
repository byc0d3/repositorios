#!/bin/bash

# Actualizar todos los paquetes
dnf -y update

# Instalar httpd
dnf -y install httpd

# Habilitar y empezar httpd
systemctl enable httpd --now

# Instalar paquetes necesarios y módulos PHP
dnf -y install epel-release
dnf -y --assumeyes install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
dnf -y --assumeyes module reset php
dnf -y --assumeyes module install php:remi-8.4
dnf -y --assumeyes install php-intl php-mbstring php-cli php-xml php-mysqlnd php-gd php-curl php-zip php-json php-imagick php-simplexml

# Reiniciar httpd para aplicar cambios
systemctl restart httpd

# Instalar Composer
wget https://getcomposer.org/installer -O composer-installer.php
php composer-installer.php --filename=composer --install-dir=/usr/local/bin

# Reiniciar httpd nuevamente
systemctl restart httpd

# Configurar el repositorio de MariaDB e instalar MariaDB
wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash
dnf -y --assumeyes install mariadb-server mariadb

# Habilitar y empezar MariaDB
systemctl enable mariadb
systemctl start mariadb

echo "Script completado. Todos los servicios han sido instalados y configurados."
