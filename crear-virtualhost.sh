#!/bin/bash

# Prompt the user for the document root
read -p "Ingrese el nombre del dominio, ejem: midominio.con: " DOMINIO

# Prompt the user for the document root
read -p "Ingrese la ruta del proyecto, ejem: /vaw/www/miproyecto: " ROOT

CONF_FILE="/etc/httpd/conf.d/${DOMINIO}.conf"

# Check if the virtualhost configuration file already exists
if [ -e "$CONF_FILE" ]; then
    read -p "Ya existe un virtualhost para el dominio \"$DOMINIO\" ¿Desea reemplazarlo? (y/n): " REPLACE
    if [ "$REPLACE" != "yes" ]; then
        echo "Operación cancelada. No se ha modificado el virtualhost actual."
        exit 1
    fi
fi

# Generate the virtualhost configuration file
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

# Restart Apache
systemctl restart httpd

echo -n "Virtualhost creado para el dominio \"$DOMINIO\" con éxito !!!."
