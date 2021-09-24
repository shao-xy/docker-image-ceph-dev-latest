#!/bin/bash -e

BASE_IMAGE=adsl/ceph-dev:v1.0
TARGET_IMAGE=adsl/ceph-dev:latest

# Check if base image exists
if test $(sudo docker images -q ${BASE_IMAGE} | wc -l) -eq 0; then
    echo -e "\e[1;31mFatal: base image ${BASE_IMAGE} not found. Build it first.\e[0m"
    exit 1
fi

# Check if target image exists:
if test $(sudo docker images -q ${TARGET_IMAGE} | wc -l) -gt 0; then
    echo -e "\e[1;35mWarning: overwriting existing image:\e[1;33m"
    sudo docker images ${TARGET_IMAGE}
	echo -e "\e[0m"
	sudo docker image rm -f ${TARGET_IMAGE}
fi

sudo docker build -t ${TARGET_IMAGE} .
#sudo docker build -t adsl/ceph-dev:v1.0 -f Dockerfile /home/cephgroup/ceph-src/
