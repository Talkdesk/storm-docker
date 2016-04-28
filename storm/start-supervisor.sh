sed -i -e "s/%zookeeper%/ec2-52-91-200-252.compute-1.amazonaws.com/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/ec2-54-172-105-234.compute-1.amazonaws.com/g" $STORM_HOME/conf/storm.yaml

echo -e "\n"
echo "storm.local.hostname: `hostname -i`" >> $STORM_HOME/conf/storm.yaml

/usr/sbin/sshd && supervisord
