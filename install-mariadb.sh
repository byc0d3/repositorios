#!/bin/bash

curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash
dnf -y --assumeyes  install mariadb-server mariadb
systemctl enable mariadb
systemctl start mariadb
