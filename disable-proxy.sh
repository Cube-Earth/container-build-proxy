#!/bin/sh
f=`docker inspect -f {{.State.Running}} build-proxy 2>/dev/null`
if [[ "$f" == "true" ]]
then
	opwd=$PWD
    echo stopping proxying container ...
	cd "`dirname \"$_\"`"
	docker-compose down
	cd "$opwd"
fi

unset http_proxy
