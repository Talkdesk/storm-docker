#!/bin/sh
apt-get install -y python-pip
wget -qO- https://get.docker.com/ | sh
pip install docker-compose
