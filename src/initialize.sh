#!/bin/bash

create_master_password() {
	while true; do
	read -p "Enter master password: " MASTER_PASSWORD
	read -p "Re-enter master password: " re_entered
	
	if [ $MASTER_PASSWORD != $re_entered ]
	then
	 echo "Passwords do not match, please try again"
	else
	 break
	fi
	done

	echo $(openssl passwd -6 -salt $(openssl rand -base64 16) $MASTER_PASSWORD) > data/.MASTER

}

check_master_password() {
	echo "Checking master password..."
}

initialize() {
	if [ -e "data/.MASTER" ]
	then
	 check_master_password
	else
	 create_master_password
	fi
}


