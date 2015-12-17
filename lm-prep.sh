#!/bin/bash

# Prepare the Live Migration requirements
# instances nfs share
MY_IP=`ifconfig eth0| awk '/inet addr/{print substr($2,6)}'`
# Generate the local.conf file
NFS_PATH=/opt/stack/data/nova
if [ $MY_IP == $CTRL_IP ]
then
    sudo apt install -y nfs-kernel-server
    mkdir -p $NFS_PATH
    grep $NFS_PATH /etc/exports
    if [ $? -ne 0 ]
    then echo "$NFS_PATH       *(rw,sync,no_subtree_check)" | sudo -E tee -a /etc/exports
    fi
    sudo service nfs-kernel-server restart
else
    mkdir -p $NFS_PATH
    sudo mount -t nfs $CTRL_IP:$NFS_PATH $NFS_PATH
    grep $NFS_PATH /etc/fstab
    if [ $? -ne 0 ]
    then echo "$CTRL_IP:$NFS_PATH $NFS_PATH  nfs defaults 0 0" | sudo -E tee -a /etc/fstab
    fi
fi

# sshkey
#ssh-keygen -N "" -f ~/.ssh/id_rsa
#ssh-copy-id
#ssh-keyscan -H 192.168.2.68 >> ~/.ssh/known_hosts
cp id_rsa.lm ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
cat id_rsa.lm.pub >> ~/.ssh/authorized_keys
echo "    StrictHostKeyChecking no" |sudo -E tee -a /etc/ssh/ssh_config
echo "    UserKnownHostsFile=/dev/null" |sudo -E tee -a /etc/ssh/ssh_config

# libvirt config
sudo sed -i "s|libvirtd_opts=\"-d\"|libvirtd_opts=\"-l -d\"|" /etc/default/libvirt-bin
sudo sed -i "s|#listen_tls = 0|listen_tls = 0|" /etc/libvirt/libvirtd.conf
sudo sed -i "s|#listen_tcp = 1|listen_tcp = 1|" /etc/libvirt/libvirtd.conf
sudo sed -i "s|#auth_tcp = \"sasl\"|auth_tcp = \"none\"|" /etc/libvirt/libvirtd.conf

sudo service libvirt-bin restart

# nova cpu mode
