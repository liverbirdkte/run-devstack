#!/bin/bash

source environment.inc
set -x

./apt-source.sh
./redsocks.sh
./pypi.sh
./prep.sh
./elk.sh
./run-devstack.sh

cd $TOPDIR
./lm-prep.sh
