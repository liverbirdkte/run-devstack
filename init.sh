#!/bin/bash

source environment.inc
set -x

if [ x"CTRL_IP" == "x" ]; then
  echo "You must tell me the CTRL_IP"
  exit -1
fi

./apt-source.sh
./redsocks.sh
./pypi.sh
./prep.sh
./run-devstack.sh
