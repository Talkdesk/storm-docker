FROM talkdesk/storm:1.0.1
MAINTAINER Talkdesk

RUN /usr/bin/config-supervisord.sh ui

EXPOSE 8080
CMD ([ ! -z "$ZOOKEEPER_HOST" ] || (echo "ZOOKEEPER_HOST env variable is not defined" && exit 1 )) \
    && ([ ! -z "$NIMBUS_HOST" ] || (echo "NIMBUS_HOST env variable is not defined" && exit 1 )) \
    && /usr/bin/start-supervisor.sh





