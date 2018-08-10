#!/bin/bash
if [ ! -e parent/ ]; then
 ./docker-ehr-parent-utils.sh
 echo "$(tput setaf 10)DONE$(tput sgr0) Parent utils created in ./parent/"
fi

# Include parent prepare script first
. ./parent/docker-ehr-config.sh

# Overriden initEnv function
overrideFunctionName initEnv parentInitEnv
initEnv() {
 parentInitEnv
 initEnvironment "EHR_DICOM_USER" "dicom-user"
 initEnvironment "EHR_DICOM_PASSWORD" $(generatePassword)
}

# Overriden cleanEnv function
overrideFunctionName cleanEnv parentCleanEnv
cleanEnv() {
 parentCleanEnv
 export EHR_DICOM_USER=
 export EHR_DICOM_PASSWORD=
}

# Overriden init function
overrideFunctionName init parentInit
init(){
 parentInit
 copyGeneratedOrthancConfig
}

copyGeneratedOrthancConfig(){
 if [ -e  ~/ehr/orthanc.json ]; then
  echo "$(tput setaf 11)WARN$(tput sgr0) File ~/ehr/orthanc.json is already existing. We will not overwrite it to keep this existing configuration safe. To get a new configuration beeing generated, you will need to empty all ~/ehr first."
 else
  cp config/orthanc.json ~/ehr/orthanc.json
  echo "$(tput setaf 10)DONE$(tput sgr0) File orthanc.json containing Orthanc configuration is now saved as ~/ehr/orthanc.json"
 fi
}

# Call the expected procedure as expected by the parent script
eval $calledProcedure
echo "$(tput setaf 10)DONE$(tput sgr0) Called $calledProcedure"
