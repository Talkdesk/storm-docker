FROM ipricegroup/ubuntu-oracle-java-8
ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Talkdesk 

RUN apt-get update; apt-get install -y unzip wget supervisor docker.io openssh-server host
RUN echo 'root:wurstmeister' | chpasswd
# RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

RUN wget -q -O - http://mirrors.fe.up.pt/pub/apache/storm/apache-storm-1.0.0/apache-storm-1.0.0.tar.gz | tar -xzf - -C /opt

ENV STORM_HOME /opt/apache-storm-1.0.0
RUN groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm

RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm

ADD storm.yaml $STORM_HOME/conf/storm.yaml
ADD cluster.xml $STORM_HOME/logback/cluster.xml
ADD config-supervisord.sh /usr/bin/config-supervisord.sh
ADD start-supervisor.sh /usr/bin/start-supervisor.sh 

ADD cacerts /cacerts
ADD config.yml /config.yml
ADD dwstart.keystore /dwstart.keystore


# # # # # # # # # # # # # # # # # # # # OPTIONAL
# Installs ZeroMQ 4
# RUN apt-get update
# RUN apt-cache search libsodium
# RUN apt-get install -y build-essential git pkg-config libtool autoconf autogen automake default-jdk

# RUN mkdir trash

# RUN cd /trash && git clone https://github.com/jedisct1/libsodium.git
# RUN cd /trash/libsodium && git checkout && ./autogen.sh
# RUN cd /trash/libsodium && ./configure && make && make check && make install

# RUN cd /root && wget http://download.zeromq.org/zeromq-4.1.4.tar.gz
# RUN cd /root && tar xzvf zeromq-4.1.4.tar.gz
# RUN cd /root/zeromq-4.1.4 && ./configure && make && make install

# Installs J-ZeroMQ natives
# RUN cd trash && git clone https://github.com/zeromq/jzmq.git
# RUN cd trash/jzmq/jzmq-jni && ./autogen.sh 
# RUN cd trash/jzmq/jzmq-jni && ./configure  
# RUN cd trash/jzmq/jzmq-jni && make
# RUN cd trash/jzmq/jzmq-jni && make install

# RUN rm -rf trash
# # # # # # # # # # # # # # # # # # # # OPTIONAL


# Set path for Java System.loadLibrary() function to detect the file (java.library.path)
ENV LD_LIBRARY_PATH /usr/local/lib/

RUN echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf
