#!/bin/bash

clear

# Get full path of current file.
SCRIPT_PATH=$(dirname $(realpath $0))
ROOT_PATH=$(dirname $SCRIPT_PATH)

docker-compose -f "$ROOT_PATH/docker-compose.yml" stop