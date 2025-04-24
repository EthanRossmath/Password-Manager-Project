#!/bin/bash

list_accounts() {

	if [ -z "$(ls -A data/passwords)" ]
	then
	 echo
	 echo "No accounts recorded"
	 return 1
	else
	 echo
	 ls -1 data/passwords
	fi

}
