#!/bin/bash
clear
# -*- ENCODING: UTF-8 -*-
##
## @author     Johann Pineda
## @copyright  Copyright © 2023 Johann Pineda
## @license    https://opensource.org/license/mit/
## @email      johann.pineda@gmail.com
## @github     https://github.com/byc0d3
## @twitter    https://twitter.com/codedjs
##

# Variables para almacenar información de opciones
AM="\033[1;33m"  ## Color Amarillo
AZ="\033[1;34m"  ## Color Azul
CY="\033[1;36m"  ## Color Cyan
GR="\033[0;37m"  ## Color Gris
MA="\033[1;35m"  ## Color Magenta
RO="\033[1;31m"  ## Color Rojo
VE="\033[1;32m"  ## Color Verde
CL="\e[0m"       ## Limpiar colores

menu() {
	clear
	echo -e "${VE}Menú Principal:${CL}"
	echo
	echo -e "${CY}(1)${CL}. Configuraciones"
	echo -e "${CY}(2)${CL}. Gestor de Paquetes"
	echo
	echo -e "${RO}(S)${CL}. Salir"
}

menu_1() {
	clear
	echo -e "${VE}Configuraciones:${CL}"
	echo
	echo -e "${CY}(1)${CL}. Configuraciones Iniciales del S.O"
	echo -e "${CY}(2)${CL}. Configuracion de 2da Interfaz de Red con Gateway para servicio."
	echo
	echo -e "${RO}(v)${CL}. Volver"
}

menu_2() {
	clear
	echo -e "${VE}Gestor de Paquetes:${CL}"
	echo
	echo -e "${CY}(1)${CL}. Apache"
	echo -e "${CY}(2)${CL}. PHP"
	echo -e "${CY}(3)${CL}. Composer"
	echo -e "${CY}(4)${CL}. MariaDB"
	echo -e "${CY}(5)${CL}. PostgreSQL"
	echo
	echo -e "${RO}(v)${CL}. Volver"
}

menu_2_1() {
	clear
	echo -e "${VE}Gestor de Paquetes:${CL}"
	echo
	echo -e "${CY}(1)${CL}. Instalar Apache"
	echo -e "${CY}(2)${CL}. Configurar VirtualHost"
	echo -e "${CY}(x)${CL}. ${RO}Desinstalar Apche${CL}"
	echo
	echo -e "${RO}(v)${CL}. Volver"
}

menu_2_2() {
	clear
	echo -e "${VE}Gestor de Paquetes:${CL}"
	echo
	echo -e "${CY}(1)${CL}. Instalar PHP 8.1"
	echo -e "${CY}(2)${CL}. Instalar PHP 8.2"
	echo -e "${CY}(3)${CL}. Instalar PHP 8.3"
	echo -e "${CY}(x)${CL}. ${RO}Desinstalar PHP${CL}"
	echo
	echo -e "${RO}(v)${CL}. Volver"
}

menu_2_3() {
	clear
	echo -e "${VE}Gestor de Paquetes:${CL}"
	echo
	echo -e "${CY}(1)${CL}. Instalar Composer"
	echo -e "${CY}(x)${CL}. Desinstalar Composer"
	echo
	echo -e "${RO}(v)${CL}. Volver"
}

menu_2_4() {
	clear
	echo -e "${VE}Gestor de Paquetes:${CL}"
	echo
	echo -e "${CY}(1)${CL}. Instalar MariaDB"
	echo -e "${CY}(x)${CL}. Desinstalar MariaDB"
	echo
	echo -e "${RO}(v)${CL}. Volver"
}

leer_opcion() {
	echo
	read -n 1 -p "Seleccione una opción: " opcion
	clear
}

proceso_finalizado() {
	echo
	echo -e "${AM}Proceso culminado satifactoriamente !!!.${CL}"
	echo
	read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
}

proceso_cancelado(){
	echo
	echo -e "${AM}Proceso cancelado !!!${CL}"
	echo
	read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
}

opcion_invalida(){
	echo -e -n "${RO}* Opción inválida.${CL} Por favor, seleccione una opción válida."
	sleep 1
}

function confirmar_accion {
	echo
	echo -e -n "¿Deseas continuar con el proceso ? ${RO}(yes)${CL}, oprima cualquier tecla para cancelar:"
	read -p "" confirm
	if [ "$confirm" != "yes" ]; then
		echo -e "Acción cancelada."
		return 1
	fi
}

function confirmar_proceso(){
	echo -e -n "¿Deseas continuar con el proceso ? ${RO}(yes)${CL}, oprima cualquier tecla para cancelar:"
}

function virtualhost(){
	read -p "Ingrese la ruta del proyecto, ejem: /vaw/www/miproyecto: " ROOT
cat << EOF > "$CONF_FILE"
<VirtualHost *:80>
	DocumentRoot "${ROOT}"
	ServerName ${DOMINIO}
	ServerAlias *.${DOMINIO}
	ErrorLog /var/log/httpd/${DOMINIO}-error_log
	CustomLog /var/log/httpd/${DOMINIO}-access_log combined
	<Directory "${ROOT}">
		AllowOverride All
		Require all granted
	</Directory>
</VirtualHost>
EOF
}

function menu_1_accion_1 {
	clear
	echo "**********************************************************************************"
	echo "* Esta opcion ejecutara los sigientes procesos en el sistema:"
	echo "**********************************************************************************"
	echo -e "* Instalara: ${VE}epel-release / nano / curl / wget / htop / traceroute / telnet / unzip / git / tar / rsync / tcpdump / util-linux-user${CL}"
	echo -e "* Podra estableser un nombre al Host: ${VE}hostnamectl${CL}"
	echo -e "* Desactivara: ${VE}SELINUX${CL}"
	echo -e "* Establecera la Zona Horaria a: ${VE}America/Caracas${CL}"
	echo -e "* Modificara la manera en que se visualizara el History: ${VE}28-11-2023 10:42:46${CL}"
	echo ""
		# Preguntar al usuario si desea desinstalar y eliminar el paquete
		echo -e -n "Si desea continuar escriba ${RO}yes${CL}, oprima cualquier tecla para cancelar:"
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			# Código a ejecutar
			# Instalación de epel-release
			dnf -y --assumeyes install epel-release

			# Actualización del sistema
			dnf -y --assumeyes update && dnf upgrade

			# Instalación de paquetes adicionales
			dnf -y --assumeyes dnf-utils nano wget htop traceroute telnet nmap tcpdump unzip tar git tar rsync util-linux-user nfs-utils

			read -p "Introduce el nombre del servidor: " NAMESERVER

			# Configuración del nombre del servidor
			hostnamectl set-hostname ${NAMESERVER}

			# Configuración de SELinux
			echo "Configurando SELinux..."
			sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/sysconfig/selinux

			# Configuración de la zona horaria
			timedatectl set-timezone America/Caracas

			# Inicio y habilitación del servicio chronyd
			systemctl start chronyd && systemctl enable chronyd

			# Configuración de HISTTIMEFORMAT en .bashrc
			echo "export HISTTIMEFORMAT='%d-%m-%Y %H:%M:%S '" >> /root/.bashrc
			source ~/.bashrc

			proceso_finalizado
		else
			proceso_cancelado
		fi
}

function menu_1_accion_2 {
	clear
	echo "**********************************************************************************"
	echo "* Esta opcion ejecutara los sigientes procesos en el sistema:"
	echo "**********************************************************************************"
	echo -e "* Configurara y creara la ruta para la segunda interfaz de red."
	echo -e "* Debe conocer la IP, la Mascara de red, y el Gateway a configurar, junto con el nombre de la interfaz, puede ejecutar comando ${VE}ip a${CL} para verificar el nombre de esta."
	echo ""

	echo -e -n "Si desea continuar escriba ${RO}yes${CL}, oprima cualquier tecla para cancelar:"
	read confirmar

	# Verificar la respuesta del usuario
	if [ "$confirmar" == "yes" ]; then
		# Código a ejecutar
		# Solicitar información al usuario
		read -p "Introduce la dirección IP del Servidor (IP): " IP
		read -p "Introduce la Prefijo de la mascara IP (PREFIX): " PREFIX
		read -p "Introduce la puerta de enlace (GW): " GW
		read -p "Introduce el nombre del dispositivo (DEVICE): " DEVICE

		# Resto de la información fija
		TABLE=5000

		# Configurar la conexión con nmcli
		nmcli con add con-name ${DEVICE} type ethernet ifname ${DEVICE} ipv4.method manual ipv4.address ${IP}/${PREFIX} ipv6.method disabled

		# Activar la conexión
		nmcli con up ${DEVICE}

		# Modificar la configuración de la conexión
		nmcli con mod ${DEVICE} ip4 ${IP}/${PREFIX} gw4 ${GW}
		nmcli con mod ${DEVICE} ipv4.route-table ${TABLE}
		nmcli con mod ${DEVICE} ipv4.routing-rules "priority 5 iif ${DEVICE} table ${TABLE}"
		nmcli con mod ${DEVICE} +ipv4.routing-rules "priority 5 from ${IP} table ${TABLE}"

		# Desactivar y activar la conexión para aplicar los cambios
		nmcli con down ${DEVICE}
		nmcli con up ${DEVICE}

		# Mostrar la información de la conexión
		nmcli con show ${DEVICE}

		proceso_finalizado
	else
		proceso_cancelado
	fi
}

function menu_2_1_accion_1 {
	clear
	# Verificar la respuesta del usuario
	if httpd -v &> /dev/null; then
		echo -e "${AM}Ya existe una instalacion de Apache.${CL}"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	else
		echo "**********************************************************************************"
		echo "* Esta opcion ejecutara la instalacion de Apache:"
		echo "**********************************************************************************"
		echo "* Se instalara Apache, se habilitara el servicio y se iniciara.."
		echo ""
		confirmar_proceso
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			# Install httpd
			dnf -y --assumeyes install httpd

			# Enable and start httpd
			systemctl enable httpd --now
			systemctl start httpd

			proceso_finalizado
		else
			proceso_cancelado
		fi
	fi
}

function menu_2_1_accion_2 {
	if httpd -v &> /dev/null; then
		clear
		echo "**********************************************************************************"
		echo "* Esta opcion configurara un virtualhost"
		echo "**********************************************************************************"
		echo "* Se creara un virtualhost en la ruta /etc/httpd/conf.d/"
		echo ""
		confirmar_proceso
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			read -p "Ingrese el nombre del dominio, ejem: midominio.con: " DOMINIO
			CONF_FILE="/etc/httpd/conf.d/${DOMINIO}.conf"
			if [ -e "$CONF_FILE" ]; then
				echo -e -n "El virtualhost para este dominio ya existe, desea modificarlo ${RO}(yes)${CL}, oprima cualquier tecla para cancelar:"
				read confirmar
				if [ "$confirmar" == "yes" ]; then
					# Llama a la funcion que creara el virualhost
					virtualhost
					# Restart Apache
					systemctl restart httpd

					echo -n "Virtualhost creado para el dominio \"$DOMINIO\" con éxito !!!."
					proceso_finalizado
				fi
			else
					# Llama a la funcion que creara el virualhost
					virtualhost
					# Restart Apache
					systemctl restart httpd

					echo -n "Virtualhost creado para el dominio \"$DOMINIO\" con éxito !!!."
					proceso_finalizado
			fi
		else
			proceso_cancelado
		fi
	else
		echo "**********************************************************************************"
		echo "* No existe una instalacion de apache en el sistema"
		echo "**********************************************************************************"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	fi
}

function menu_2_1_accion_x {
	clear
	# Verificar la respuesta del usuario
	if httpd -v &> /dev/null; then
		echo "**********************************************************************************"
		echo "* Esta opcion Desinstalara Apache:"
		echo "**********************************************************************************"
		echo -e "* Se Desinstalara Apache, y se eliminara toda configuracion del mismo"
		echo ""
		confirmar_proceso
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			systemctl stop httpd
			dnf -y remove httpd
			dnf -y autoremove
			dnf -y clean all

			proceso_finalizado
		else
			proceso_cancelado
		fi
	else
		echo "**********************************************************************************"
		echo "* No existe una instalacion de apache en el sistema"
		echo "**********************************************************************************"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	fi
}

function menu_2_2_accion_1 {
	clear
	# Verificar la respuesta del usuario
	if php -v &> /dev/null; then
		php_version=$(php -v | awk '/^PHP/ {print $2}')
		echo -e "${AM}Ya existe una instalacion de PHP, en su version $php_version.${CL}"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	else
		echo "**********************************************************************************"
		echo "* Esta opcion ejecutara la instalacion de PHP 8.1:"
		echo "**********************************************************************************"
		echo "* Se instalara PHP 8.1"
		echo ""
		confirmar_proceso
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			# Install PHP
			dnf module list php
			dnf config-manager --set-enabled powertools
			dnf -y --assumeyes install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
			dnf -y --assumeyes module reset php
			dnf -y --assumeyes module install php:remi-8.1
			dnf -y --assumeyes install php-intl php-mbstring php-cli php-xml php-mysqlnd php-gd php-curl php-zip php-json php-imagick php-simplexml

			printf "<?php phpinfo(); ?>" > /var/www/html/test.php
			systemctl restart httpd

			proceso_finalizado
		else
			proceso_cancelado
		fi
	fi
}

function menu_2_2_accion_2 {
	clear
	# Verificar la respuesta del usuario
	if php -v &> /dev/null; then
		php_version=$(php -v | awk '/^PHP/ {print $2}')
		echo -e "${AM}Ya existe una instalacion de PHP, en su version $php_version.${CL}"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	else
		echo "**********************************************************************************"
		echo "* Esta opcion ejecutara la instalacion de PHP 8.2:"
		echo "**********************************************************************************"
		echo "* Se instalara PHP 8.2"
		echo ""
		confirmar_proceso
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			# Install PHP
			dnf module list php
			dnf config-manager --set-enabled powertools
			dnf -y --assumeyes install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
			dnf -y --assumeyes module reset php
			dnf -y --assumeyes module install php:remi-8.2
			dnf -y --assumeyes install php-intl php-mbstring php-cli php-xml php-mysqlnd php-gd php-curl php-zip php-json php-imagick php-simplexml

			printf "<?php phpinfo(); ?>" > /var/www/html/test.php
			systemctl restart httpd

			proceso_finalizado
		else
			proceso_cancelado
		fi
	fi
}

function menu_2_2_accion_3 {
	clear
	# Verificar la respuesta del usuario
	if php -v &> /dev/null; then
		php_version=$(php -v | awk '/^PHP/ {print $2}')
		echo -e "${AM}Ya existe una instalacion de PHP, en su version $php_version.${CL}"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	else
		echo "**********************************************************************************"
		echo "* Esta opcion ejecutara la instalacion de PHP 8.3:"
		echo "**********************************************************************************"
		echo "* Se instalara PHP 8.3"
		echo ""
		confirmar_proceso
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			# Install PHP
			dnf module list php
			dnf config-manager --set-enabled powertools
			dnf -y --assumeyes install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
			dnf -y --assumeyes module reset php
			dnf -y --assumeyes module install php:remi-8.3
			dnf -y --assumeyes install php-intl php-mbstring php-cli php-xml php-mysqlnd php-gd php-curl php-zip php-json php-imagick php-simplexml

			printf "<?php phpinfo(); ?>" > /var/www/html/test.php
			systemctl restart httpd

			proceso_finalizado
		else
			proceso_cancelado
		fi
	fi
}

function menu_2_2_accion_x {
	clear
	# Verificar la respuesta del usuario
	if php -v &> /dev/null; then
		echo "**********************************************************************************"
		echo "* Esta opcion Desinstalara PHP:"
		echo "**********************************************************************************"
		echo -e "* Se Desinstalara PHP y todas sus dependencias del sistema"
		echo ""
		confirmar_proceso
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			dnf -y module reset php
			dnf -y remove php*
			dnf -y autoremove
			dnf -y clean all

			proceso_finalizado
		else
			proceso_cancelado
		fi
	else
		echo "**********************************************************************************"
		echo "* No existe una instalacion de PHP en el sistema"
		echo "**********************************************************************************"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	fi
}

function menu_2_3_accion_1 {
	clear
	if php -v &> /dev/null; then
		if composer -V &> /dev/null; then
			composer_version=$(composer -V | grep -oP 'Composer version \K[0-9]+\.[0-9]+\.[0-9]+')
			echo -e "${AM}Ya existe una instalacion de Composer, en su version $composer_version.${CL}"
			echo ""
			read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
		else
			echo "**********************************************************************************"
			echo "* Esta opcion ejecutara la instalacion de Composer $composer_version:"
			echo "**********************************************************************************"
			echo "* Se instalara Composer"
			echo ""
			confirmar_proceso
			read confirmar
			# Verificar la respuesta del usuario
			if [ "$confirmar" == "yes" ]; then
				# Install PHP
				wget https://getcomposer.org/installer -O composer-installer.php
				php composer-installer.php --filename=composer --install-dir=/usr/local/bin
				systemctl restart httpd

				proceso_finalizado
			else
				proceso_cancelado
			fi
		fi
	else
		echo "**********************************************************************************"
		echo "* No se encontro ninguna version de PHP instalada en el sistema"
		echo "**********************************************************************************"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	fi
}

function menu_2_3_accion_x {
	clear
	# Verificar la respuesta del usuario
	if composer -V &> /dev/null; then
		composer_version=$(composer -V | grep -oP 'Composer version \K[0-9]+\.[0-9]+\.[0-9]+')
		echo "**********************************************************************************"
		echo "* Esta opcion Desinstalara Composer $composer_version:"
		echo "**********************************************************************************"
		echo -e "* Se Desinstalara Composer y todas sus dependencias del sistema"
		echo ""
		confirmar_proceso
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			rm /usr/local/bin/composer
			rm -rf ~/.composer
			dnf -y autoremove
			dnf -y clean all

			proceso_finalizado
		else
			proceso_cancelado
		fi
	else
		echo "**********************************************************************************"
		echo "* No existe una instalacion de Composer en el sistema"
		echo "**********************************************************************************"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	fi
}

function menu_2_4_accion_1 {
	clear
	# Verificar la respuesta del usuario
	if mariadb --version &> /dev/null; then
		mariadb_version=$(/usr/bin/mariadb --version | awk '{print $3}' | cut -d'-' -f1)
		echo -e "${AM}Ya existe una instalacion de MariaDB, en su version $mariadb_version.${CL}"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	else
		echo "**********************************************************************************"
		echo "* Esta opcion ejecutara la instalacion de MariaDB es su ultima version estable"
		echo "**********************************************************************************"
		echo "* Se instalara MariaDB"
		echo ""
		confirmar_proceso
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			# Install PHP
			curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash
			dnf -y --assumeyes  install mariadb-server mariadb
			systemctl enable mariadb
			systemctl start mariadb

			proceso_finalizado
		else
			proceso_cancelado
		fi
	fi
}

function menu_2_4_accion_x {
	clear
	# Verificar la respuesta del usuario
	if mariadb --version &> /dev/null; then
		mariadb_version=$(/usr/bin/mariadb --version | awk '{print $3}' | cut -d'-' -f1)
		echo "**********************************************************************************"
		echo "* Esta opcion Desinstalara MariaDB $mariadb_version"
		echo "**********************************************************************************"
		echo -e "* Se Desinstalara MariaDB y todas sus dependencias del sistema"
		echo ""
		confirmar_proceso
		read confirmar
		# Verificar la respuesta del usuario
		if [ "$confirmar" == "yes" ]; then
			systemctl stop mariadb
			dnf -y remove mariadb mariadb-server
			rm -rf /var/lib/mysql
			rm -rf /etc/my.cnf
			dnf -y autoremove
			dnf -y clean all

			proceso_finalizado
		else
			proceso_cancelado
		fi
	else
		echo "**********************************************************************************"
		echo "* No existe una instalacion de MariaDB en el sistema"
		echo "**********************************************************************************"
		echo ""
		read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
	fi
}

while true; do
	menu
	leer_opcion
	case $opcion in
		1)
			while true; do
				menu_1
				leer_opcion
				case $opcion in
					1)
						menu_1_accion_1
						;;
					2)
						menu_1_accion_2
						;;
					v)
						break  # Salir del bucle interno (submenú)
						;;
					*)
						opcion_invalida
						;;
				esac
			done
			;;
		2)
			while true; do
				menu_2
				leer_opcion
				case $opcion in
					1)
						while true; do
							menu_2_1
							leer_opcion
							case $opcion in
								1)
									confirmar_accion || continue
									menu_2_1_accion_1
									;;
								2)
									confirmar_accion || continue
									menu_2_1_accion_2
									;;
								x)
									confirmar_accion || continue
									menu_2_1_accion_x
									;;
								v)
									break  # Salir del bucle interno (submenú)
									;;
								*)
									opcion_invalida
									;;
							esac
						done
						;;
					2)
						while true; do
							menu_2_2
							leer_opcion
							case $opcion in
								1)
									confirmar_accion || continue
									menu_2_2_accion_1
									;;
								2)
									confirmar_accion || continue
									menu_2_2_accion_2
									;;
								3)
									confirmar_accion || continue
									menu_2_2_accion_3
									;;
								x)
									confirmar_accion || continue
									menu_2_2_accion_x
									;;
								v)
									break  # Salir del bucle interno (submenú)
									;;
								*)
									opcion_invalida
									;;
							esac
						done
						;;
					3)
						while true; do
							menu_2_3
							leer_opcion
							case $opcion in
								1)
									confirmar_accion || continue
									menu_2_3_accion_1
									;;
								x)
									confirmar_accion || continue
									menu_2_3_accion_x
									;;
								v)
									break  # Salir del bucle interno (submenú)
									;;
								*)
									opcion_invalida
									;;
							esac
						done
						;;
					4)
						while true; do
							menu_2_4
							leer_opcion
							case $opcion in
								1)
									confirmar_accion || continue
									menu_2_4_accion_1
									;;
								x)
									confirmar_accion || continue
									menu_2_4_accion_x
									;;
								v)
									break  # Salir del bucle interno (submenú)
									;;
								*)
									opcion_invalida
									;;
							esac
						done
						;;
					v)
						break  # Salir del bucle interno (submenú)
						;;
					*)
						opcion_invalida
						;;
				esac
			done
			;;
		s)
			echo "Saliendo del programa. ¡Hasta luego!"
			exit 0
			;;
		*)
			opcion_invalida
			;;
	esac
	clear  # Opcional: Limpiar la pantalla antes de mostrar el menú nuevamente
done
