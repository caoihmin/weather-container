#!/bin/bash
HOST_IP=$(hostname --all-ip-addresses | awk '{print $1}')
export HOST_IP
exec docker-compose $@
