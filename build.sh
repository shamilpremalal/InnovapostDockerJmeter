#!/bin/bash

JMETER_VERSION="5.3"

# Example build line
# --build-arg IMAGE_TIMEZONE="America/Montreal"
docker build  --build-arg JMETER_VERSION=${JMETER_VERSION} -t "innovapost/jmeter:${JMETER_VERSION}" .
