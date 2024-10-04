#!/bin/bash

# Install httpd
dnf -y --assumeyes install httpd

# Enable and start httpd
systemctl enable httpd --now
systemctl start httpd
