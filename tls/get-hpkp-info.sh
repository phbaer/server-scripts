#!/bin/sh
primary_suffix=psw
backup_suffix=backup
max_age=15768000
add_details=""

cmdargs="$0 [primary cert key] [backup cert key] [sub]?"
example="$0 server.key server-backup.key sub"

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "$cmdargs"
	echo "Example: $example"
	exit 2;
fi

if [  "$3" = "sub" ]; then
	add_details="; includeSubdomains"
fi

primary=`openssl rsa -in $1 -outform der -pubout 2> /dev/null | openssl dgst -sha256 -binary 2> /dev/null | base64`
backup=`openssl rsa -in $2 -outform der -pubout 2> /dev/null | openssl dgst -sha256 -binary 2> /dev/null | base64`

echo "Public-Key-Pins 'pin-sha256=\"$primary\"; pin-sha256=\"$backup\"; max-age=$max_age$add_details'"
