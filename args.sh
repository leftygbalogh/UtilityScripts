#!/bin/sh

if [[ $# -gt 0 ]]; then
	VARIABLE=$#
	echo "$# number of arguments"
	echo "$1 is the first argument"


	shift

	echo "$# arguments after shift"
	echo "$1 is the first argument after the shift"
	echo "$VARIABLE was the original"
fi