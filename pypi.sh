#!/bin/bash

# replace pypi local mirror
PIP_CONF=/home/ubuntu/.pip
mkdir $PIP_CONF
cat >> $PIP_CONF/pip.conf << EOF
[global]
index-url = http://shtaurus.sh.intel.com/pypi/simple
trusted-host = shtaurus.sh.intel.com
#index-url = http://linux-ftp.jf.intel.com/pub/mirrors/pypi/web/simple
#trusted-host = linux-ftp.jf.intel.com
EOF

# /root also need to set the pypi mirror
sudo cp -rf $PIP_CONF /root
