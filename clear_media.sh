#!/bin/bash

# This script must delete older then 500 days media images. 

# go do docker directory whith docker containers directory
# count targets based on dircetoris whith docker container
# NUM_OF_DIRS=$(find -type d | sed -e 's/\.\///g' | grep -v '\.' | tr '\n' ' ' | wc -w)
# DIRS=$(find -type d | sed -e 's/\.\///g' | grep -v '\.' | tr '\n' ' ')

# count targets based on active docker containers
NUM_OF_DIRS=$(sudo docker ps | grep gearman | tr ' ' '\n' | grep _gearman | awk -F '_' '{print $1}' | tr '\n' ' ' | wc -w)
DIRS=$(sudo docker ps | grep gearman | tr ' ' '\n' | grep _gearman | awk -F '_' '{print $1}' | tr '\n' ' ')
COUNTER=0
while [ "$COUNTER" -lt "$NUM_OF_DIRS" ]
do
    cd /docker;
    CLIENT=$(echo "$DIRS" | awk '{print $1}')
    cd "$CLIENT"
    docker-compose down;
    cd ".."
    cd /var/lib/docker/volumes/"$CLIENT"_media/_data/images
    find . -type f -mtime +500 -exec rm -rf {} \;
    cd /docker/"$CLIENT";
    docker-compose up -d;
    DIRS=$(echo "$DIRS" | sed -e 's/'$CLIENT' //g')
    COUNTER=$((++COUNTER))
done
    


