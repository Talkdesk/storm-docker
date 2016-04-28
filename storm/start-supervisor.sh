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

if valid_ip $nimbus_ip; then nimbus_ip_parsed=$nimbus_ip; else nimbus_ip_parsed=`host $nimbus_ip | awk '{ print $4 }'`; fi
if valid_ip $zookeeper_ip; then zookeeper_ip_parsed=$zookeeper_ip; else zookeeper_ip_parsed=`host $zookeeper_ip | awk '{ print $4 }'`; fi

sed -i -e "s/%zookeeper%/$zookeeper_ip_parsed/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/$nimbus_ip_parsed/g" $STORM_HOME/conf/storm.yaml

echo -e "\n"

# It is not critical to solve the DNS for the hostname. So far it is only used for debugging and storm-ui purposes.
# if valid_ip $hostname_ip; then hostname_parsed=$hostname_ip; else hostname_parsed=`host $hostname_ip | awk '{ print $4 }'`; fi
hostname_parsed=$hostname_ip

echo "storm.local.hostname: $hostname_parsed" >> $STORM_HOME/conf/storm.yaml

echo "#########################################"
cat $STORM_HOME/conf/storm.yaml
echo "#########################################"

/usr/sbin/sshd && supervisord
