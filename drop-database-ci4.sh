#!/bin/bash

# Solicitar el nombre de la base de datos y la contraseña una vez
read -p "Ingrese el nombre de la base de datos: " db_name
read -s -p "Ingrese la contraseña de MariaDB: " password

# Eliminar la base de datos si existe
mariadb -u root -p$password -e "DROP DATABASE IF EXISTS \`$db_name\`;"

# Crear la base de datos nuevamente con el juego de caracteres utf8mb4 y colación utf8mb4_unicode_ci
mariadb -u root -p$password -e "CREATE DATABASE \`$db_name\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

echo "La base de datos '$db_name' ha sido recreada con el conjunto de caracteres utf8mb4_unicode_ci".

# Ejecutar el comando 'php spark migrate'
php spark migrate
