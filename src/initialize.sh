#!/bin/bash

# gets user to enter new master password and encrypts using openssl passwd
create_master_password() {
	while true; do
	read -p "Enter new master password: " MASTER_PASSWORD
	read -p "Re-enter new master password: " re_entered

		if [ $MASTER_PASSWORD != $re_entered ]
		then
	 		echo "Passwords do not match, please try again"
		else
	 		break
		fi
	done

	# creating a new file/overwriting which contains the encrypted master password
	echo $(openssl passwd -6 -salt $(openssl rand -base64 16) $MASTER_PASSWORD) > data/.MASTER

}

# extracting the salt from an encrypted string
get_salt() {
  
  [[ $1 =~ ^\$6\$(.*)\$(.*)$ ]]
  echo -n ${BASH_REMATCH[1]}
  
}

# user inputs master password and the function checks if the input matches the contents from data/.MASTER
check_master_password() {
	password_hash=$(cat data/.MASTER)
	password_salt=$(get_salt $password_hash)

	while true; do
		echo "Please enter your master password: "
		read -s MASTER_PASSWORD # using -s to hide the input for security reasons
		user_hash=$(openssl passwd -6 -salt $password_salt $MASTER_PASSWORD)

		while [ $password_hash != $user_hash ]; do
			echo "Incorrect. Please try again."
			read -s MASTER_PASSWORD
        		user_hash=$(openssl passwd -6 -salt $password_salt $MASTER_PASSWORD)
		done

		break
	done

	return 0

}

# checks if a master password exists. If so, asks user to input master password. Otherwise, prompts user to create 
# a new password
initialize() {
	if [ -e "data/.MASTER" ]
	then
	 	check_master_password
	else
	 	create_master_password
	fi
}


