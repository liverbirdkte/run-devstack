#!/bin/bash
set -x
# replace the apt source with local mirror
#sudo sed -i "s|nova.clouds.archive.ubuntu.com|$LOCAL_APT_SRC|" /etc/apt/sources.list
#sudo sed -i "s|security.ubuntu.com|$LOCAL_APT_SRC|" /etc/apt/sources.list
# sudo sed -i 's|nova.clouds.archive.ubuntu.com|shtaurus.sh.intel.com|' /etc/apt/sources.list
# sudo sed -i 's|security.ubuntu.com|shtaurus.sh.intel.com|' /etc/apt/sources.list
sudo -E tee /etc/apt/sources.list >>/dev/null << EOF
deb http://$LOCAL_APT_SRC/ubuntu/ trusty main universe
deb http://$LOCAL_APT_SRC/ubuntu/ trusty-updates main universe
deb http://$LOCAL_APT_SRC/ubuntu/ trusty-backports main universe
deb http://$LOCAL_APT_SRC/ubuntu/ trusty-security main universe
EOF
sudo apt update -y
sudo apt install -y libvirt-bin
