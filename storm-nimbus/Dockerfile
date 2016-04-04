FROM talkdesk/storm:0.10.0
MAINTAINER Wurstmeister

RUN /usr/bin/config-supervisord.sh nimbus 
RUN /usr/bin/config-supervisord.sh drpc

EXPOSE 6627
EXPOSE 3772
EXPOSE 3773
CMD /usr/bin/start-supervisor.sh
