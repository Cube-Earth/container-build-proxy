#!/bin/sh
git clone https://github.com/Cube-Earth/container-build-proxy "$HOME/.containers/build-proxy"
echo 'export PATH=$PATH:$HOME/.containers/build-proxy' >> "$HOME/.bash_profile"
docker pull cubeearth/build-proxy
