#!/bin/bash
set -x
# Clone the latest devstack
cd ~
git clone /opt/git/openstack-dev/devstack.git

cd ~/devstack
# generate local.conf
./gen-localconf.sh

./stack.sh
