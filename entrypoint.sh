#!/bin/bash

# Sets script to fail if any command fails.
set -e

set_xauth() {
	echo xauth add $DISPLAY . $XAUTH
	touch /root/.Xauthority
	xauth add $DISPLAY . $XAUTH
}

run_openastro() {
	set_xauth
	/usr/bin/openastro
}

print_usage() {
echo "
Usage:	$0 COMMAND
Openastro
"
}

case "$1" in
    help)
        print_usage
        ;;
    openastro)
	run_openastro
        ;;
    *)
        exec "$@"
esac
