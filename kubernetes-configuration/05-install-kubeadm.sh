#!/bin/bash

sed -i 's/^.*swap/#&/' /etc/fstab
swapoff -a

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

sudo yum install -y kubelet-1.22.5-0 kubeadm-1.22.5-0 kubectl-1.22.5-0 --disableexcludes=kubernetes

sudo systemctl enable --now kubelet
