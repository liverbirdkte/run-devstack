#!/bin/bash
set -x
# replace the apt source with local mirror
sudo sed -i "s|nova.clouds.archive.ubuntu.com|$LOCAL_APT_SRC|" /etc/apt/sources.list
sudo sed -i "s|security.ubuntu.com|$LOCAL_APT_SRC|" /etc/apt/sources.list
# sudo sed -i 's|nova.clouds.archive.ubuntu.com|shtaurus.sh.intel.com|' /etc/apt/sources.list
# sudo sed -i 's|security.ubuntu.com|shtaurus.sh.intel.com|' /etc/apt/sources.list
sudo apt update -y
