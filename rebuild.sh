#!/bin/bash

docker build -t="talkdesk/zookeeper:3.4.8" zookeeper
docker build -t="talkdesk/storm:0.9.4" storm
docker build -t="talkdesk/storm-nimbus:0.9.4" storm-nimbus
docker build -t="talkdesk/storm-supervisor:0.9.4" storm-supervisor
docker build -t="talkdesk/storm-ui:0.9.4" storm-ui
