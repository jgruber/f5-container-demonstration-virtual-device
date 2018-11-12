#!/bin/bash
DIR=$(pwd);
cd install-init
sudo chown root:root ./*
sudo rm ../install-init.tar.gz
sudo tar -cvzf ../install-init.tar.gz ./*
