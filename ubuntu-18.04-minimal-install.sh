#!/bin/bash

if [ ! -d /home/f5admin ]; then
    /usr/sbin/useradd --create-home --shell $(which bash) --groups sudo f5admin
    echo "f5admin:f5admin" | /usr/sbin/chpasswd
fi

apt update
apt install -y apt-transport-https ca-certificates curl software-properties-common openssh-server openssh-client net-tools
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt update
apt install -y docker-ce docker-compose
docker pull v2tec/watchtower
docker pull jgruber/as3validatortool:latest
docker pull jgruber/f5-appsvcs-demo-web:latest
docker pull jgruber/f5-appsvcs-demo:latest
docker pull mongo:latest
docker pull f5devcentral/f5-as3-container:latest
docker pull f5devcentral/f5-api-services-gateway:latest

usermod -g docker f5admin

cd /
wget https://github.com/jgruber/f5-container-demonstration-virtual-device/raw/master/install-init.tar.gz
tar xvzf install-init.tar.gz
systemctl daemon-reload
systemctl enable docker.as3validator.service
systemctl enable docker.f5-appsvcs-demo-web.service
systemctl enable docker.watchtower.service

reboot



