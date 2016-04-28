#!/bin/bash
zookeeper_ip="ec2-52-91-200-252.compute-1.amazonaws.com"
nimbus_ip="ec2-54-172-105-234.compute-1.amazonaws.com"
hostname_ip="ec2-54-172-105-234.compute-1.amazonaws.com"

# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

sed -i -e "s/%zookeeper%/$zookeeper_ip/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/$nimbus_ip/g" $STORM_HOME/conf/storm.yaml

echo -e "\n"

if valid_ip $nimbus_ip; then myhostname=$hostname_ip; else myhostname=`host $hostname_ip | awk '{ print $4 }'`; fi

echo "storm.local.hostname: $myhostname" >> $STORM_HOME/conf/storm.yaml

echo "#########################################"
cat $STORM_HOME/conf/storm.yaml
echo "#########################################"

/usr/sbin/sshd && supervisord
