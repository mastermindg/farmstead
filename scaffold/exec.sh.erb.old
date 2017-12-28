#!/usr/bin/env bash

# Script to start Farmstead on Docker

trap mytrap ERR #0 #EXIT 0 HUP INT QUIT PIPE TERM

mytrap() {
	excode=$?
	if [ $excode -ne 0 ]; then
		printf "\tFailed!\n"
    	exit 1
    fi
}

success() {
	printf "\tSucceeded\n"
}

# Counts down a number of seconds
countdown() {
	secs=$1
	while [ $secs -gt 0 ]; do
  	echo -ne "$secs\033[0K\r"
   	sleep 1
   	: $((secs--))
	done
}

echo "Cleaning up old environment"
docker-compose stop > /dev/null 2>&1
docker-compose rm -f > /dev/null 2>&1
#docker stop $(docker ps -a -q) > /dev/null 2>&1
#docker rm $(docker ps -a -q) > /dev/null 2>&1
success

echo "Building new environment"
docker-compose build > /dev/null 2>&1
success

echo "Starting MySQL and Zookeeper"
docker-compose up -d mysql zookeeper > /dev/null 2>&1
success

echo "Sleeping"
countdown 10

echo "Starting dorothy"
docker-compose up -d dorothy > /dev/null 2>&1
success

echo "Create and Seed MySQL DB"
docker-compose exec dorothy rails db:setup > /dev/null 2>&1
success

echo "Starting everything else"
docker-compose up -d > /dev/null 2>&1
success