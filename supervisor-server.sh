#!/bin/sh
if [ -f "SETUP_OK" ]
then
	echo "Everything is installed already."
else
	sh install.sh
	docker build -t="talkdesk/storm:0.10.0" storm
	docker build -t="talkdesk/storm-supervisor:0.10.0" storm-supervisor
	touch SETUP_OK
fi

cd storm-supervisor; docker-compose up -d
cd storm-supervisor; docker-compose logs -f