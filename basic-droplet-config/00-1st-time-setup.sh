#!/bin/bash

# Update
sudo yum update -y
sudo yum install kexec-tools nano vim-enhanced epel-release net-tools wget yum-utils -y

# Add new user
adduser user
usermod --password $(echo user_pass | openssl passwd -1 -stdin) user
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

# Edit hostname
cat << EOF >> /etc/hosts

# hostname for private cluster
10.104.0.7 bastion-host
10.104.0.2 k8s-master-1 
10.104.0.4 k8s-master-2
10.104.0.6 k8s-master-3 
10.104.0.3 k8s-worker-1
10.104.0.5 k8s-worker-2
EOF
