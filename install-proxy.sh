#!/bin/sh
f1="$HOME/.bash_profile"
git clone https://github.com/Cube-Earth/container-build-proxy "$HOME/.containers/build-proxy"
[[ -L "$f1" ]] && ( f2=`readlink -f "$f1"` &&  rm "$f1" && echo ". $f2" > "$f1" )
echo 'export PATH=$PATH:$HOME/.containers/build-proxy' >> "$HOME/.bash_profile"
docker pull cubeearth/build-proxy
