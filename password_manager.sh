#!/bin/bash

source src/initialize.sh

show_menu() {
while true; do
echo
echo "Password Manager Menu"
echo "1. Add new password"
echo "2. Get password"
echo "3. List accounts"
echo "4. Exit"
echo

read -p "Choose an option (1 - 4)" option

case $option in
	1)
	    echo
	    echo "You have selected 'Add new password'. This is not yet implemented"
	    ;; 
        2) 
            echo
	    echo "You have selected 'Get password'. This is not yet implemented"
	    ;; 
        3) 
            echo
	    echo "You have selected 'List accounts'. This is not yet implemented"
	    ;;
        4) 
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
initialize

while true; do
	show_menu
done
}

#You may choose to later inlcude arguments to main.
main "$@"
#!/bin/bash


