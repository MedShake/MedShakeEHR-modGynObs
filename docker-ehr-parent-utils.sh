#!/bin/bash
# make sure a parent folder is existing
mkdir -p parent
# Get the parent of the container from which we will get the parent files
PARENT_IMAGE=$(grep -oP 'FROM \K.*' Dockerfile-web)
echo "$(tput setaf 10)DONE$(tput sgr0) Found parent image $PARENT_IMAGE"
# Create a temporary container
TEMP_CONTAINER=$(docker create $PARENT_IMAGE)
echo "$(tput setaf 10)DONE$(tput sgr0) Creating temporary container with id $TEMP_CONTAINER"
# Loop for eatch line of "parentutils" file
while IFS= read -r file ; do
 docker cp $TEMP_CONTAINER:$file ./parent
 echo "$(tput setaf 10)DONE$(tput sgr0) Fetched $file from parent image"
done < "parentutils"
docker rm $TEMP_CONTAINER
echo "$(tput setaf 10)DONE$(tput sgr0) Removed temporary container with id $TEMP_CONTAINER"
