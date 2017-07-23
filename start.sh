#!/bin/bash
docker login -u="caoihmin" -p="AgentSmith101"
HOST_IP=$(hostname --all-ip-addresses | awk '{print $1}')
export HOST_IP
exec docker-compose $@ > /dev/null 2>&1 &
