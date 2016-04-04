FROM talkdesk/storm:0.10.0
MAINTAINER Wurstmeister

RUN /usr/bin/config-supervisord.sh nimbus 
RUN /usr/bin/config-supervisord.sh drpc

EXPOSE 6627
EXPOSE 3772
EXPOSE 3773
CMD /usr/bin/start-supervisor.sh

ADD topology.jar /topology.jar

EXPOSE 5555

CMD (sleep 30; storm jar /topology.jar com.talkdesk.storm.examples.zmq.TopologyMain &> /Nimbus.log) & echo "Starting NIMBUS" & /usr/bin/start-supervisor.sh