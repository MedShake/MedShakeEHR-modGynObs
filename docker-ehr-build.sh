#!/bin/bash
docker build -t medshake-ehr-gynobs-db:latest . -f Dockerfile-db
docker build -t medshake-ehr-gynobs-web:latest . -f Dockerfile-web
