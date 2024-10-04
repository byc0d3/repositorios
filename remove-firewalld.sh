#!/bin/bash

# Detener el servicio firewalld
sudo systemctl stop firewalld

# Deshabilitar el servicio firewalld
sudo systemctl disable firewalld

# Eliminar el paquete firewalld
sudo dnf remove firewalld -y

# Eliminar el directorio de configuración de firewalld
sudo rm -rf /etc/firewalld
