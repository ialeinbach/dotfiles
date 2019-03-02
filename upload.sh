#!/bin/bash

if ! [[ $(git status 2> /dev/null) =~ "nothing to commit" ]]; then
	echo "Please clean up repo before updating."
	exit 1
fi

case $# in
	0) cmp -s ~/.bashrc .bashrc || cp ~/.bashrc .
	   cmp -s ~/.vimrc  .vimrc  || cp ~/.vimrc  .
	;;
	1) case "$1" in
		   "bashrc") cmp -s ~/.bashrc .bashrc || cp ~/.bashrc . ;;
		   "vimrc" ) cmp -s ~/.vimrc  .vimrc  || cp ~/.vimrc  . ;;
		   *       ) echo "Invalid argument."
		             exit 1
		   ;;
	   esac
	;;
	*) echo "Too many arguments."
	   exit 1
	;;
esac

if ! [[ $(git status 2> /dev/null) =~ "nothing to commit" ]]; then
	git add .                              && \
	git commit --allow-empty-message -m '' && \
	git push origin master
fi
