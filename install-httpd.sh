#!/bin/bash

# Install httpd
dnf -y install httpd

# Enable and start httpd
systemctl enable httpd --now
systemctl start httpd
