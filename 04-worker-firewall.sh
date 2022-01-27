#!/bin/bash

firewall-cmd --add-masquerade --permanent 
firewall-cmd --add-port=179/tcp --permanent 
    firewall-cmd --add-port 10250/tcp --permanent
    firewall-cmd --add-port 30000-32767/tcp --permanent
    firewall-cmd --reload
