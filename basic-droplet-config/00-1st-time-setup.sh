#!/bin/bash

# Update
sudo yum update -y
sudo yum install kexec-tools nano vim-enhanced epel-release net-tools wget yum-utils -y

# Add new user
adduser user
passwd userpass
gpasswd -a user wheel
echo "server        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/server

# Install Firewalld and setup basic network rules
sudo yum install firewalld -y
sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
sudo systemctl enable firewalld

# Configure Time Zone
timedatectl set-timezone Asia/Jakarta

# Configure NTP server
yum install ntp -y 
systemctl start ntpd
systemctl enable ntpd 