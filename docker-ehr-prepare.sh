#!/bin/sh
# Prepare some local folder structure to ensure volume sharing with containers
mkdir -p -m 700 ~/ehr/dicom/
echo "$(tput setaf 10)DONE$(tput sgr0) File structure checked"

# Create a default configuration file
export ORTHANC_CONF=~/ehr/orthanc.json
if [ ! -e $ORTHANC_CONF ]; then
 if [ ! -e ./config/orthanc.json ]; then
  echo "$(tput setaf 11)WARN$(tput sgr0) ./config/orthanc.json is not existing please run update script first."
 else
  cp ./config/orthanc.json $ORTHANC_CONF
  echo "$(tput setaf 10)DONE$(tput sgr0) File ./config/orthanc.json copied to $ORTHANC_CONF"
 fi
else
 echo "$(tput setaf 11)WARN$(tput sgr0) There is an existing $ORTHANC_CONF, so we will not copy a new one over it."
fi
