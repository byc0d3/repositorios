#!/bin/bash

# Solicitar el nombre del dominio
while true; do
	read -p "Ingrese el nombre del dominio: " dominio
	if [[ "$dominio" =~ ^[a-zA-Z0-9]+$ ]]; then
		dominio="${dominio}.local"
		break
	else
		echo "El nombre del dominio solo puede contener letras y números. Inténtelo de nuevo."
	fi
done

read -p "Ingrese la ruta del DocumentRoot: " root

# Crear el archivo de configuración del virtual host
vhost_conf="/etc/httpd/conf.d/${dominio}.conf"
document_root="/var/www/${root}"

# Verificar si el archivo de configuración del virtual host ya existe
if [ -f "$vhost_conf" ]; then
	read -p "El virtual host ${dominio} ya existe. ¿Desea reemplazarlo? (s/n): " reemplazar
	if [ "$reemplazar" != "s" ]; then
		echo "Operación cancelada. No se ha creado ni modificado ningún virtual host."
		exit 1
	fi
fi

echo "<VirtualHost *:80>
	DocumentRoot \"${document_root}\"
	ServerName ${dominio}
	ServerAlias *.${dominio}

	ErrorLog /var/log/httpd/${dominio}-error_log
	CustomLog /var/log/httpd/${dominio}-access_log combined

	<Directory \"${document_root}\">
		AllowOverride All
		Require all granted
	</Directory>
</VirtualHost>" > $vhost_conf

echo "Virtual host creado en ${vhost_conf}"

# Preguntar si se desea crear el virtual host SSL
read -p "¿Desea crear también el virtual host SSL? (s/n): " crear_ssl

if [ "$crear_ssl" == "s" ]; then
	ssl_vhost_conf="/etc/httpd/conf.d/${dominio}-ssl.conf"

	echo "<VirtualHost *:443>
	DocumentRoot \"${document_root}\"
	ServerName ${dominio}
	ServerAlias *.${dominio}
	# Redirigir todo el tráfico HTTP a HTTPS
	RewriteEngine On
	RewriteCond %{HTTPS} off
	RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

	ErrorLog /var/log/httpd/${dominio}-ssl_error_log
	CustomLog /var/log/httpd/${dominio}-ssl_access_log combined

	SSLEngine on
	SSLCertificateFile /etc/pki/tls/certs/wildcard.local.crt
	SSLCertificateKeyFile /etc/pki/tls/private/wildcard.local.key

	<Directory \"${document_root}\">
		AllowOverride All
		Require all granted
	</Directory>
</VirtualHost>" > $ssl_vhost_conf

	echo "Virtual host SSL creado en ${ssl_vhost_conf}"

	# Agregar redirección al primer virtual host
	sed -i '/<\/Directory>/a \ \n\t# Redirigir todo el tráfico HTTP a HTTPS\n\tRewriteEngine On\n\tRewriteCond %{HTTPS} off\n\tRewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]' $vhost_conf
	echo "Redirección HTTP a HTTPS agregada en ${vhost_conf}"
fi

# Reiniciar el servicio httpd
systemctl restart httpd
echo "Servicio httpd reiniciado"
