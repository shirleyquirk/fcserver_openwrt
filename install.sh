#!/bin/bash
#usage: install.sh user@open.wrt.server.ip
if [ -z "$1"  ]
then
    echo "Usage: ./install.sh <user>@<open.wrt.ip>"
    exit 1
fi
#try to log into fcserver with publickey
ssh -o ControlPath=None \
    -o LogLevel=INFO \
    -o PreferredAuthentications=publickey \
    -o IdentitiesOnly=yes $1 exit 2>/tmp/logfile.stderr </dev/null
if [ $? != 0 ]; then
    echo "Copying publickey to openwrt router"
    ssh $1 "tee -a /etc/dropbear/authorized_keys" < ~/.ssh/id_rsa.pub
    ssh $1 "test -e /root/.ssh"
    if [ $? != 0 ]; then
        ssh $1 "mkdir /root/.ssh"
    fi
    ssh $1 "test -e /root/.ssh/authorized_keys"
    if [ $? != 0 ]; then
        ssh $1 "cd /root/.ssh && ln -s /etc/dropbear/authorized_keys"
    fi
fi
echo "installing dependencies"
ssh $1 "opkg update"
ssh $1 "opkg install libstdcpp"
echo "Installing files to router"
#TODO do an rsync test for age
scp ./fadecandyserver $1:/etc/init.d/
scp ./fcserver $1:/usr/bin/
scp ./fcserver.config $1:/etc/
echo "starting fcserver..."
ssh $1 "/etc/init.d/fadecandyserver enable"
ssh $1 "/etc/init.d/fadecandyserver restart"
