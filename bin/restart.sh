#!/bin/bash

clear

# Get full path of current file.
SCRIPT_PATH=$(dirname $(realpath $0))

"$SCRIPT_PATH/stop.sh"
"$SCRIPT_PATH/start.sh"

exit 0