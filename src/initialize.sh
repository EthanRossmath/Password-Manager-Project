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

get_salt() {
  
  [[ $1 =~ ^\$6\$(.*)\$(.*)$ ]]
  echo -n ${BASH_REMATCH[1]}
  
}

check_master_password() {
	password_hash=$(cat data/.MASTER)
	password_salt=$(get_salt $password_hash)

	while true; do
	
	echo "Please enter your master password: "
	read -s MASTER_PASSWORD
	user_hash=$(openssl passwd -6 -salt $password_salt $MASTER_PASSWORD)

	if [ $password_hash != $user_hash ]
	then
	 continue
	else
	 break
	fi
	done
	
	return 0

}

initialize() {
	if [ -e "data/.MASTER" ]
	then
	 check_master_password
	else
	 create_master_password
	fi
}


