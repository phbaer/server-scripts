#!/bin/bash
#
# concat-chained.sh [certificate] [target base name]
#

# List all the intermediate certificates and up to the root...
chain="iantermediate.crt root.crt"

cmdargs="$0 [certificate] [target base name]"
example="$0 certificate.crt some.server.net"

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "$cmdargs"
	echo "Example: $example"
	exit 2;
fi

openssl x509 -subject -issuer -in $1 > $2.crt
for C in $chain; do
	openssl x509 -subject -issuer -in $C >> $2.crt
done

