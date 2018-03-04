#!/bin/sh
f=`docker inspect -f {{.State.Running}} build-proxy 2>/dev/null`
if [[ ! "$f" == "true" ]]
then
	opwd=$PWD
	echo starting proxying container ...
	cd "`dirname \"${BASH_SOURCE[0]}\"`"
	docker-compose up -d
	cd "$opwd"
	sleep 1
fi


#container_ip=`docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' build-proxy`

if [[ "`uname -r`" = *"coreos"* ]]
then
	ip=`ifconfig | awk '/^[a-zA-Z]/ { split($0,a,":"); n=a[1] } / +inet / && n ~ /^ens[0-9]+$/ { match ($0, " inet [0-9.]+"); ip=substr($0,RSTART+6,RLENGTH-6); print ip }' | head -n 1`
else
	ip=`ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | head -n 1`
fi

export http_proxy="http://$ip:8889"
echo "proxy: $http_proxy"

#iptables -t nat -A OUTPUT -p tcp -m owner ! --uid-owner replicator-user --dport 80 -j REDIRECT --to-port 8080
#pf --> pass in on em0 proto tcp from any to any port 80 rdr-to 192.168.1.20 port 8000


#echo "rdr pass on lo0 inet proto tcp from any to 127.0.0.1 port 5432 -> 192.168.1.104 port 5432" | sudo pfctl -ef -
