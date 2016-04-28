sed -i -e "s/%zookeeper%/52.91.200.252/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/54.172.105.234/g" $STORM_HOME/conf/storm.yaml

echo -e "\n"
echo "storm.local.hostname: `hostname -i`" >> $STORM_HOME/conf/storm.yaml

/usr/sbin/sshd && supervisord
