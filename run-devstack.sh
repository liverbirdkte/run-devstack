#!/bin/bash
set -x

# Clone the latest devstack
cd ~
git clone /opt/git/openstack-dev/devstack.git

cd ~/devstack
# generate local.conf
$TOPDIR/gen-localconf.sh

mkdir files
cp /opt/git/images/get-pip.py files/
./stack.sh
