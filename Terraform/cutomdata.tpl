#! /bin/bash

apt -y update
apt -y install software-properties-common
add-apt-repository ppa:deadsnakes/ppa
apt -y update
apt -y install python3.8