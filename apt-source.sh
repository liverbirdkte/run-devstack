#!/bin/bash

# replace the apt source with local mirror
sudo sed -i 's|nova.clouds.archive.ubuntu.com|linux-ftp.bj.intel.com/pub/mirrors|' /etc/apt/sources.list
sudo sed -i 's|security.ubuntu.com|linux-ftp.bj.intel.com/pub/mirrors|' /etc/apt/sources.list
# sudo sed -i 's|nova.clouds.archive.ubuntu.com|shtaurus.sh.intel.com|' /etc/apt/sources.list
# sudo sed -i 's|security.ubuntu.com|shtaurus.sh.intel.com|' /etc/apt/sources.list
sudo apt update
