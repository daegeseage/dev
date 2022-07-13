#!/bin/bash

# This script must delete older then 500 days media images. 


# Set key for df command for more simple arithmetic operation whith bytes
BLOCK_NUM_KEY="-B1"

# Measure size before cleaning 
BEFORE=$( df "$BLOCK_NUM_KEY" | grep '/dev/mapper/vg_sys-docker' | awk '{print $3}' )

# count targets based on active docker containers
NUM_OF_DIRS=$(docker ps | grep gearman | tr ' ' '\n' | grep _gearman | awk -F '_' '{print $1}' | tr '\n' ' ' | wc -w)
DIRS=$(docker ps | grep gearman | tr ' ' '\n' | grep _gearman | awk -F '_' '{print $1}' | tr '\n' ' ')
CONTAINER_BEFORE=$DIRS
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

# Count docker container upped after clearing
CONTAINER_AFTER=$(docker ps | grep gearman | tr ' ' '\n' | grep _gearman | awk -F '_' '{print $1}' | tr '\n' ' ')

# Measure size after cleaning 
AFTER=$( df "$BLOCK_NUM_KEY" | grep '/dev/mapper/vg_sys-docker' | awk '{print $3}' )

let CLEANED="BEFORE - AFTER"
DATE=$(date)
WAS_CLEANED=$(echo -n "was cleaned:  "; numfmt --to=iec "$CLEANED")
cd /docker
echo -e "------------\n""containers before:$CONTAINER_BEFORE\ncontainers after:$CONTAINER_AFTER\n""$WAS_CLEANED" on "$DATE" >> test_log
cp test_log /home/nsazhnev
