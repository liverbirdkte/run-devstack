#!/bin/bash

# replace pypi local mirror
PIP_CONF=/home/ubuntu/.pip
mkdir $PIP_CONF
cat >> $PIP_CONF/pip.conf << EOF
[global]
index-url = $LOCAL_PYPI
trusted-host = $PYPI_HOST
EOF

# /root also need to set the pypi mirror
sudo cp -rf $PIP_CONF /root
