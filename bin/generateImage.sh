#!/bin/bash

PARAMS=''  # Positional arguments.
REPOSITORY=''
USERNAME='jherrerotardon'  # By default username to project owner.
TAG='latest'
UPLOAD=0  # Flag to indicate if is neccesart push image.

PROJECT_PATH=$(dirname $(dirname "$(realpath "$0")"))

help()
{
  echo -e "Usage:\n"
  echo -e "Options:"
  echo -e "\t -h|--help:\t\t Print usage."
  echo -e "\t -u|--upload:\t\t Push image to dockerhub."
  echo -e "\n"

  echo -e "Arguments:"
  echo -e "\t -t|--tag:\t\t Sets image tag. By default: latest."
  echo -e "\t -r|--repository:\t Sets repository name. Is mandatory."
  echo -e "\t -u|--username:\t\t Sets username. By default porject owner (jherrerotardon)."

  exit 0
}

check_flag_with_argument()
{
  # Checks if argument is not empty and not starts with '-'.
  if [ -z "$2" ] || [ ${2:0:1} == "-" ]; then
    echo "Error: Argument for '$1' is missing" >&2
    exit 1
  fi    
}

parse_arguments()
{
  while (( "$#" )); do
    case "$1" in
      -h|--help)
          help
          ;;
      -u|--upload)
        UPLOAD=1
        shift
        ;;
      -t|--tag)
        check_flag_with_argument $@
        TAG=$2
        shift 2
        ;;
      -r|--repository)
        check_flag_with_argument $@
        REPOSITORY=$2
        shift 2
        ;;
      -u|--username)
        check_flag_with_argument $@
        USERNAME=$2
        shift 2
        ;;
      -*|--*=) # unsupported flags
        echo "Error: Unsupported flag $1" >&2
        exit 1
        ;;
      *) # preserve positional arguments
        PARAMS="${PARAMS} $1"
        shift
        ;;
    esac
  done
}

# Main code starts here.
parse_arguments $@
eval set -- ${PARAMS}  # $et positional arguments in their proper place

if [ -z "$REPOSITORY" ];then
  echo "Error: empty repository." >&2
  exit 1
fi

DOCKERFILE_FOlDER="${PROJECT_PATH}/files/${REPOSITORY}"
DOCKERFILE="${DOCKERFILE_FOlDER}/Dockerfile"
if [ ! -f  ${DOCKERFILE} ]; then
  echo "Error: no Dockerfile in ${REPOSITORY}. Check that ${DOCKERFILE} exists." >&2
  exit 1
fi

IMAGE="${USERNAME}/${REPOSITORY}"
IMAGE_TAGGED="${IMAGE}:${TAG}"

echo -e "\033[0;32mBuilding image ${IMAGE}...\033[0m" && sleep 2
docker build -t ${IMAGE} ${DOCKERFILE_FOlDER}
docker tag ${IMAGE} ${IMAGE_TAGGED}

echo -e "\n\n"

if [ ${UPLOAD} -eq 1 ]; then
  echo -e "\033[0;32mPushing ${IMAGE_TAGGED}...\033[0m"
  docker push ${IMAGE_TAGGED}
fi