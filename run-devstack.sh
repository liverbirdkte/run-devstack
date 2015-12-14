#!/bin/bash
set -x

OLD_DIR=$PWD
# Clone the latest devstack
cd ~
git clone /opt/git/openstack-dev/devstack.git

cd ~/devstack
# generate local.conf
$OLD_DIR/gen-localconf.sh

./stack.sh
