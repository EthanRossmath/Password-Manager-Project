#!/bin/bash


# generates random 24 byte base64 string
generate_password() {
	openssl rand -base64 24
}

# encrypts a plaintext password using -aes-256-cbc using the master password on file
encrypt_password() { #$1=master password, $2=plaintext password
	echo "$2" | openssl enc -aes-256-cbc -pbkdf2 -iter 20000 -a -pass "pass:$1" 
}

# generates a new encrypted password
new_password() { #$1=master password
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
		     		encrypt_password $1 $password > data/passwords/${account_name}
		     		break
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



decrypt_password() { #$1 = master password, $2 = base64 encoded ciphertext to decrypt
        echo "$2" | openssl enc -d -aes-256-cbc -pbkdf2 -iter 20000  -a -pass "pass:$1"
}
 
display_password() { #$1 = plaintext
        echo "$1"
        read -p "Press Enter after done viewing" option
        clear
}


retrieve_password() { #$1 = master password
        master_password=$1
        
        if [ -z "$(ls -A data/passwords)" ]
        then 
        	echo
         	echo "No usernames on record"
         	return 1
        fi

        while true; do
        	read -p "Enter account name: " account_name
        
        	if [ ! -f "data/passwords/${account_name}" ]
         	then
         		read -p "No account records. Press 'q' to quit and any other key to continue: " option
         		case $option in
                	'q')
                		return 0
                		;;

                	*)
                		;;
         		esac
        	else
         		break
        	fi
        done

        encrypted_password=$(cat "data/passwords/${account_name}")
        plaintext_password=$(decrypt_password "$master_password" "$encrypted_password")
        display_password "$plaintext_password"
}
