#!/bin/bash
firewall-cmd --permanent --zone=public --add-source=10.10.0.0/16
firewall-cmd --permanent --zone=public --add-source=10.104.0.0/20
firewall-cmd --add-masquerade --permanent 
firewall-cmd --add-port=179/tcp --permanent 
firewall-cmd --add-port 10250/tcp --permanent
firewall-cmd --add-port 30000-32767/tcp --permanent
firewall-cmd --reload
