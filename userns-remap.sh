#!/bin/bash

groupadd -g 99999 dockremap && 
useradd -u 99999 -g dockremap -s /bin/false dockremap && 
echo "dockremap:99999:65536" >> /etc/subuid && 
echo "dockremap:99999:65536" >>/etc/subgid

echo "
  {
   \"userns-remap\": \"default\"
  }
" > /etc/docker/daemon.json

systemctl daemon-reload && systemctl restart docker
