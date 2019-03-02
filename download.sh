#!/bin/bash

git fetch

if [[ $(git status 2> /dev/null) =~ "Your branch is behind" ]]; then
	echo "Please pull all changes to local repo."
	exit 1
fi

case $# in
	0) cp .bashrc ~ && cp .vimrc ~
	;;
	1) case "$1" in
		   "bashrc") cp .bashrc ~ ;;
		   "vimrc" ) cp .vimrc ~  ;;
		   *       ) echo "Invalid argument."
		             exit 1
		   ;;
	   esac
	;;
	*) echo "Too many arguments."
	   exit 1
	;;
esac
