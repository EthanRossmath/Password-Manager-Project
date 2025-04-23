#!/bin/bash

create_master_password() {
	echo "Creating master password..."
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


