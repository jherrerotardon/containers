#!/bin/bash

clear

# Get full path of current file.
SCRIPT_PATH=$(dirname $(realpath $0))
ROOT_PATH=$(dirname $SCRIPT_PATH)

if [[ ! -f ${ROOT_PATH}/.env ]]; then
    echo -e "\033[0;33m/!\ \033[0mPlease, configure .env file."

    exit 1
fi

docker-compose -f "$ROOT_PATH/docker-compose.yml" up --detach

exit 0