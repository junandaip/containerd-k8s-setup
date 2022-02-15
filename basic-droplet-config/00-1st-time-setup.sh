#!/bin/bash

# Add new user
adduser demo
passwd demo
gpasswd -a demo wheel

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