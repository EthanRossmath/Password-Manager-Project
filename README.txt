This is the README for the Linux Password Manager project, part of the Field's
Institute's Quantitative Information Security Program.

#-#-# IMPORTANT NOTES #-#-#
	- To use password-manager your active directory must be password-manager.

	- Call the password manager via the command 

	$ bash password-manager.sh

#-#-# FIRST BOOT #-#-#

Please follow these steps.

	1. After making password-manager your active directory, please enter the
	following commands 

	$ chmod +x password-manager.sh
	$ bash password-manager.sh

	2. You will be prompted to enter a new master password. Please enter any
	password you like. You will be asked to confirm your choice by re-entering
	your master password.

#-#-# USING THE BASH SCRIPT #-#-#

Upon calling password-manager.sh, you will be prompted to enter your master password.
After entering the correct password, you will be sent to a menu with 4 options

1. Add new password

Selecting this option will prompt you to enter an account name. Upon confirming, an
encrypted 24 byte base 64 password will be generated and saved to 
data/passwords/account_name. 

If this account already exists and you would still like
to generate a new password, exit the script and enter the following command from 
password-manager

$ rm data/passwords/account_name

and re-run the script.

2. Get password

Selecting this option will prompt you to enter an account name or 'q' to quit. The 
password stored will then be printed in your terminal. After you are done viewing 
your password, hitting enter will clear the terminal and return you back to the main
menu. If 'q' is selected you will be returned to the main menu.

If an account does not exist, you can either press 'q' to quit or enter another 
account name.

3. List accounts

Upon selecting this option, all current accounts will be listed. If no accounts are
in the data/passwords directory, no account will be listed.

4. Exit

Exits the script.


