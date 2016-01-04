# Variables

# CHANGE THE CTRL_IP, otherwise by default install AIO devstack
# The controller's IP
#export CTRL_IP=192.168.2.93
export CTRL_IP=`ifconfig eth0| awk '/inet addr/{print substr($2,6)}'`

# Two available apt source mirror
# shtaurus.sh.intel.com
# linux-ftp.bj.intel.com/pub/mirrors
export LOCAL_APT_SRC=shtaurus.sh.intel.com

# Two available pypi mirror, you must modify LOCAL_PYPI and PYPI_HOST together
# shtaurus.sh.intel.com/pypi/simple
# linux-ftp.jf.intel.com/pub/mirrors/pypi/web/simple
# pypi.ir.intel.com/simple
export LOCAL_PYPI=shtaurus.sh.intel.com/pypi/simple
export PYPI_HOST=shtaurus.sh.intel.com

# Available intel proxies
# 10.240.252.16 - proxy-prc
# 10.239.4.80 - child-prc
export INTEL_PROXY=child-prc.intel.com

# Flag to tell whether to setup the Live migratioin requirements before run devstack
# user sshkey/libvirt/nova-compute/nfs changes
# export LM_ENABLED="True|False"
export LM_ENABLED="True"

export TOPDIR=`pwd`
