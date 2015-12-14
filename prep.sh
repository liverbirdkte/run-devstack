#!/bin/bash
set -x
# mount the nfs directory as git_base
sudo apt install -y nfs-common git
sudo mkdir /opt/git
sudo mount -t nfs 192.168.0.2:/data/git /opt/git

# instances nfs share

# sshkey
#ssh-keygen -N "" -f ~/.ssh/id_rsa
#ssh-copy-id
#ssh-keyscan -H 192.168.2.68 >> ~/.ssh/known_hosts
# libvirt config

# nova cpu mode
