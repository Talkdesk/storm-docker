FROM talkdesk/storm:1.0.1
MAINTAINER Talkdesk

RUN /usr/bin/config-supervisord.sh nimbus 
RUN /usr/bin/config-supervisord.sh drpc

EXPOSE 6627
EXPOSE 3772
EXPOSE 3773
EXPOSE 5555

CMD ([ ! -z "$ZOOKEEPER_HOST" ] || (echo "ZOOKEEPER_HOST env variable is not defined" && exit 1 )) \  
    && /usr/bin/start-supervisor.sh
