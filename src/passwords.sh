#!/bin/bash

generate_password() {
	echo $(openssl rand -base64)
}

encrypt_password() {
	echo $(echo "$2" | openssl enc -aes-256-cbc -pbkdf2 -a -pass "pass:$1") 
}

new_password() {
	while true; do
	read -p "Please enter an account name (or 'q' to quit): " account_name

	if [ $account_name == 'q' ]; then
	echo "Returning to the main menu..."
	break
	fi

	if [ -f data/passwords/${account_name} ]; then
	 echo "$account_name already has a password"
	 continue
	
	else
	read -p "Is $account_name correct? (y/n)" option
	
	case $option in
		'y') 
		     echo "Username confirmed. Password being generated"
		     password=$(generate_password)
		     echo "$(encrypt_password $1 $password)" >> data/passwords/${account_name}
		     exit 0
		     ;;
		'n')
                     echo "Please try again"
                     echo 
		     continue
		     ;;
		*)
		     echo "Please enter 'y' for 'Yes' or 'n' for 'No'"
		     continue
		     ;;
	esac
	fi
	done
	
}
