#!/bin/bash

terraform apply
host_ip=$(terraform show | grep assigned_nat_ip)
host_ip=$(echo $host_ip | sed 's/[^=]*=//')
echo $host_ip
shopt -s extglob
host_ip="${host_ip##*( )}"
shopt -u extglob
host_ip="keng@$host_ip"
echo $host_ip
sleep 50
ssh -i /home/keng/.ssh/id_rsa $host_ip -oUserKnownHostsFile=/dev/null 'sudo apt-get update'
ssh -i /home/keng/.ssh/id_rsa $host_ip -oUserKnownHostsFile=/dev/null 'sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual'
ssh -i /home/keng/.ssh/id_rsa $host_ip -oUserKnownHostsFile=/dev/null 'sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'
ssh -i /home/keng/.ssh/id_rsa $host_ip -oUserKnownHostsFile=/dev/null 'sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
ssh -i /home/keng/.ssh/id_rsa $host_ip -oUserKnownHostsFile=/dev/null 'sudo apt-get update'
ssh -i /home/keng/.ssh/id_rsa $host_ip -oUserKnownHostsFile=/dev/null 'sudo apt-get -y install docker.ce'
ssh -i /home/keng/.ssh/id_rsa $host_ip -oUserKnownHostsFile=/dev/null 'sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)"'
ssh -i /home/keng/.ssh/id_rsa $host_ip -oUserKnownHostsFile=/dev/null 'sudo chmod +x /usr/local/bin/docker-compose'
ssh -i /home/keng/.ssh/id_rsa $host_ip -oUserKnownHostsFile=/dev/null 'sudo mkdir /etc/hmwk'
ssh -i /home/keng/.ssh/id_rsa $host_ip -oUserKnownHostsFile=/dev/null 'cd /etc/hmwk; sudo git clone https://github.com/caoihmin/weather-container.git'
