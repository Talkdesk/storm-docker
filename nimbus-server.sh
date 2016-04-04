#!/bin/sh
if [ -f "SETUP_OK" ] then
	echo "Everything is installed already."
else
	sh install.sh
	docker build -t="talkdesk/storm:0.10.0" storm
	docker build -t="talkdesk/storm-nimbus:0.10.0" storm-nimbus
	docker build -t="talkdesk/storm-ui:0.10.0" storm-ui
	touch SETUP_OK
fi

cd storm-ui; docker-compose up -d
docker-compose logs -f