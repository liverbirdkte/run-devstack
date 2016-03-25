#!/bin/bash
set -x
MY_IP=`ifconfig eth0| awk '/inet addr/{print substr($2,6)}'`
# Generate the local.conf file
if [ $MY_IP == $CTRL_IP ]; then
cat > local.conf << EOF
[[post-config|\$GLANCE_API_CONF]]
[DEFAULT]
notification_driver = messaging
notification_topics = notifications, searchlight_indexer
rpc_backend = 'rabbit'

[[post-config|\$NOVA_CONF]]
[DEFAULT]
notification_driver = messaging
notification_topics = notifications, searchlight_indexer
rpc_backend = 'rabbit'
notify_on_state_change=vm_and_task_state

[[post-config|\$NEUTRON_CONF]]
[DEFAULT]
notification_driver = messaging
notification_topics = notifications, searchlight_indexer
rpc_backend = 'rabbit'

[[post-config|\$CINDER_CONF]]
[DEFAULT]
notification_driver = messaging
notification_topics = notifications, searchlight_indexer
rpc_backend = 'rabbit'

[[local|localrc]]
NOVNC_REPO=/opt/git/kanaka/noVNC.git
GIT_BASE=/opt/git
IMAGE_URLS=file:///opt/git/images/cirros-0.3.4-x86_64-uec.tar.gz
DOWNLOAD_DEFAULT_IMAGES=False

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

#for neutron
disable_service n-net
enable_service q-svc
enable_service q-agt
enable_service q-dhcp
enable_service q-l3
enable_service q-meta
enable_service neutron
disable_service tempest

enable_service heat h-api h-api-cfn h-api-cw h-eng
enable_service s-proxy s-object s-container s-account
enable_plugin zaqar https://github.com/openstack/zaqar
enable_plugin designate https://git.openstack.org/openstack/designate

enable_plugin searchlight https://github.com/openstack/searchlight
enable_service searchlight-api
enable_service searchlight-listener

#cinder
enable_service c-api c-sch c-vol
VOLUME_GROUP="stack-volumes"
VOLUME_NAME_PREFIX="volume-"
VOLUME_BACKING_FILE_SIZE=10250M

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
else
cat > local.conf << EOF
[[local|localrc]]
NOVNC_REPO=/opt/git/kanaka/noVNC.git
GIT_BASE=/opt/git

HOST_IP=$MY_IP
SERVICE_HOST=$CTRL_IP
DATABASE_PASSWORD=123
ADMIN_PASSWORD=123
MYSQL_PASSWORD=123
RABBIT_PASSWORD=guest
SERVICE_PASSWORD=123
SERVICE_TOKEN=ADMIN

#FIXED_RANGE=192.168.128.0/24
MULTI_HOST=True
MYSQL_HOST=$CTRL_IP
RABBIT_HOST=$CTRL_IP
GLANCE_HOSTPORT=$CTRL_IP:9292

ENABLED_SERVICES=n-cpu,q-agt

NOVA_VNC_ENABLED=True
NOVNCPROXY_URL="http://$CTRL_IP:6080/vnc_auto.html"
VNCSERVER_LISTEN=0.0.0.0
VNCSERVER_PROXYCLIENT_ADDRESS=$CTRL_IP

RECLONE=False
#enable Logging
LOGFILE=/opt/stack/logs/stack.sh.log
VERBOSE=True
LOG_COLOR=True
SCREEN_LOGDIR=/opt/stack/logs
EOF
fi
