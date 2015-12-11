#!/bin/bash

# Clone the latest devstack
cd ~
git clone /opt/git/openstack-dev/devstack.git

# generate local.conf
MY_IP=`ifconfig eth0| awk '/inet addr/{print substr($2,6)}'`
cd ~/devstack
cat > local.conf << EOF
[[local|localrc]]
NOVNC_REPO=/opt/git/kanaka/noVNC.git
GIT_BASE=/opt/git

HOST_IP=$MY_IP
SERVICE_HOST=$MY_IP
DATABASE_PASSWORD=123
ADMIN_PASSWORD=123
MYSQL_PASSWORD=123
RABBIT_PASSWORD=guest
SERVICE_PASSWORD=123
SERVICE_TOKEN=ADMIN

#FIXED_RANGE=192.168.128.0/24
MULTI_HOST=True

disable_service n-net
disable_service tempest
disable_service heat
enable_service q-svc
enable_service q-agt
enable_service q-dhcp
enable_service q-l3
enable_service q-meta
enable_service quantum
enable_service n-novnc

NOVA_VNC_ENABLED=True
NOVNCPROXY_URL="http://$MY_IP:6080/vnc_auto.html"
VNCSERVER_LISTEN=0.0.0.0
VNCSERVER_PROXYCLIENT_ADDRESS=$MY_IP

RECLONE=False
#enable Logging
LOGFILE=/opt/stack/logs/stack.sh.log
VERBOSE=True
LOG_COLOR=True
SCREEN_LOGDIR=/opt/stack/logs
EOF

./stack.sh
