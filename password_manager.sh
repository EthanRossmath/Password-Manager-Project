#!/bin/bash

# source commands
source src/initialize.sh
source src/passwords.sh
source src/utils.sh

# the show menu command. Produces 4 options and allows the user to select one
show_menu() {
while true; do
	echo # Adding an echo above and below for readability
	echo "Password Manager Menu"
	echo "1. Add new password"
	echo "2. Get password"
	echo "3. List accounts"
	echo "4. Exit"
	echo

	read -p "Choose an option (1 - 4)" option

	case $option in
	1) # calls the function new_password from src/passwords.sh with argument $MASTER_PASSWORD
	   # this allows the user to input a account name and produces an encrypted 24 byte base 64 string
	   # using aes-256-cbc with password $MASTER_PASSWORD
		new_password "$MASTER_PASSWORD" 
	    	;; 
        2) # calls the function retrieve_password from src/passwords.sh with argument $MASTER_PASSWORD. This
	   # prompts the user to input an existing account name, then produces the plaintext of the password.
            	retrieve_password "$MASTER_PASSWORD"
	    	;; 
        3) # calls the function list_accounts from src/utils.sh. This lists all existing accounts.
            	list_accounts
	    	;;
        4) # implementing a new while loop and case to give users the ability to confirm that they would
	   # like to exit the password manager
	    	while true; do

            		echo
            		read -p "Are you sure you wish to exit? (y/n)" exit_option

            		case $exit_option in
                	"y")
                		echo 
                     		echo "Exiting..."
                     		exit 0     
                     		;;
                	"n") 
                     		echo
                     		echo "Returning back to menu"
		     		break
                     		;;
                	*) 
                     		echo
                     		echo "Please select a 'y' for yes and 'n' for no"
                     		;;
            		esac
	    	done
            	;; 
        *) 
            	echo
            	echo "Please select a number 1-4"
            	;;
	esac

	echo

done
}
main() {
# calls upon the function initialize from src/initialize.sh. This prompts the user to produce a master password if they 
# have not already. Otherwise, if the user has already chosen a master password, it then prompts the user to provide the
# master password and checks if the prompt agrees with the stored master password.
	initialize

# loop show_menu function until the user makes a selection.
	while true; do
		show_menu
	done
}

#You may choose to later inlcude arguments to main.
main "$@"
#!/bin/bash


