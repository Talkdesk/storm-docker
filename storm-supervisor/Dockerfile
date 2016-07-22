FROM talkdesk/storm:1.0.1
MAINTAINER Talkdesk

EXPOSE 6700
EXPOSE 6701
EXPOSE 6702
EXPOSE 6703
EXPOSE 6704
EXPOSE 6705
EXPOSE 6706
EXPOSE 6707
EXPOSE 6708
EXPOSE 6709
EXPOSE 6710
EXPOSE 6711

EXPOSE 8000
EXPOSE 5555
EXPOSE 10514
EXPOSE 22

RUN /usr/bin/config-supervisord.sh supervisor
RUN /usr/bin/config-supervisord.sh logviewer
CMD ([ ! -z "$ZOOKEEPER_HOST" ] || (echo "ZOOKEEPER_HOST env variable is not defined" && exit 1 )) \
    && ([ ! -z "$NIMBUS_HOST" ] || (echo "NIMBUS_HOST env variable is not defined" && exit 1 )) \
    && /usr/bin/start-supervisor.sh
