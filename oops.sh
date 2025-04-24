#!/bin/bash

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
                #continue
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

retrieve_password "howdy"
