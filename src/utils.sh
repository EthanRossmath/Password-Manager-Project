#!/bin/bash

# when called, this function lists all accounts in data/passwords as a vertical stack.
list_accounts() {

	if [ -z "$(ls -A data/passwords)" ] # checks if any accounts are listed in data/passwords
	then
	 	echo
	 	echo "No accounts recorded"
	 	return 1
	else
	 	echo
	 	ls -1 data/passwords # prints the names of the accounts in a vertical stack
	fi

}
