#!/usr/bin/bash

if [ ! -d "/home/$USER/data" ]; then
	mkdir -p /home/$USER/data/wordpress
	mkdir -p /home/$USER/data/mariadb
fi