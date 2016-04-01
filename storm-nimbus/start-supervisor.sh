export IP=`hostname -i`
sed -i -e "s/%zookeeper%/ec2-52-91-200-252.compute-1.amazonaws.com/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/$IP/g" $STORM_HOME/conf/storm.yaml

echo "storm.local.hostname: `hostname -i`" >> $STORM_HOME/conf/storm.yaml

/usr/sbin/sshd && supervisord
