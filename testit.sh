#!/bin/bash

host_ip=$(terraform show | grep assigned_nat_ip)
host_ip=$(echo $host_ip | sed 's/[^=]*=//')
echo $host_ip
