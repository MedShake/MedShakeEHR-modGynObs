#!/bin/bash
if [ ! -e parent/ ]; then
 ./docker-ehr-parent-utils.sh
 echo "$(tput setaf 10)DONE$(tput sgr0) Parent utils created in ./parent/"
fi

# Call the parent prepare first
./parent/docker-ehr-prepare.sh

# Prepare some local folder structure to ensure volume sharing with containers
mkdir -p -m 700 ~/ehr/dicom/
echo "$(tput setaf 10)DONE$(tput sgr0) File structure checked"
