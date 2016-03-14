#!/bin/bash

docker build -t="talkdesk/zookeeper" zookeeper
docker build -t="talkdesk/storm" storm
docker build -t="talkdesk/storm-nimbus" storm-nimbus
docker build -t="talkdesk/storm-supervisor" storm-supervisor
docker build -t="talkdesk/storm-ui" storm-ui
