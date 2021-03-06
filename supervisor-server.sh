#!/bin/sh
if [ -f "SETUP_OK" ]
then
	echo "Everything is installed already."
else
	sh install.sh
	docker build -t="talkdesk/storm:1.0.0" storm
	docker build -t="talkdesk/storm-supervisor:1.0.0" storm-supervisor
	touch SETUP_OK
fi

cd storm-supervisor; docker-compose up -d
docker-compose logs
