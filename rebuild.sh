#!/bin/bash
docker build -t="talkdesk/storm:1.0.1" storm
docker build -t="talkdesk/storm-nimbus:1.0.1" storm-nimbus
docker build -t="talkdesk/storm-supervisor:1.0.1" storm-supervisor
docker build -t="talkdesk/storm-ui:1.0.1" storm-ui
docker build -t="talkdesk/zookeeper:3.4.8" zookeeper
