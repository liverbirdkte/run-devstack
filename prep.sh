#!/bin/bash
set -x
# mount the nfs directory as git_base
sudo apt install -y nfs-common git
sudo mkdir /opt/git
sudo mount -t nfs 192.168.0.2:/data/git /opt/git

#if [ $LM_ENABLED = "True" ]
#then
#./lm-prep.sh
#fi
