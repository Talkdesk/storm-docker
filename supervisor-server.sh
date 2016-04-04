#!/bin/sh
apt-get install python-pip
wget -qO- https://get.docker.com/ | sh
pip install docker-compose

docker build -t="talkdesk/storm:0.10.0" storm
docker build -t="talkdesk/storm-supervisor:0.10.0" storm-supervisor