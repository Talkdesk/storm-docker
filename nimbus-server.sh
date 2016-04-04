#!/bin/sh
wget -qO- https://get.docker.com/ | sh
pip install docker-compose

docker build -t="talkdesk/storm:0.10.0" storm
docker build -t="talkdesk/storm-nimbus:0.10.0" storm-nimbus
docker build -t="talkdesk/storm-ui:0.10.0" storm-ui