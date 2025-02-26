#!/bin/bash
BOLD='\033[1m'
RED='\033[0;31m'
BLUE='\033[1;34;48m'
GREEN='\033[32m'
WHITE='\033[34m'
YELLOW='\033[33m'
NO_COLOR='\033[0m'

TARGET_ARCH=$(uname -m)
DOCKERFILE="docker/build.iperf3.dockerfile"
IMAGE_NAME=iperf3_dev
DEV_CONTAINER="iperf3_client"
DEV_CONTAINER_WORKDIR="/iperf3"

function info() {
    (echo >&2 -e "[${WHITE}${BOLD}INFO${NO_COLOR}] $*")
}

function error() {
    (echo >&2 -e "[${RED}ERROR${NO_COLOR}] $*")
}

function warning() {
    (echo >&2 -e "${YELLOW}[WARNING] $*${NO_COLOR}")
}

function ok() {
    (echo >&2 -e "[${GREEN}${BOLD} OK ${NO_COLOR}] $*")
}

function print_delim() {
    echo "=============================================="
}

function rm_container() {
    if docker ps -q -f status=created -f name="$1" || docker ps -q -f status=running -f name="$1"; then
        echo ":: Removing stopped container - $1"
        docker rm -f "$1"
    fi
}

function stop_container() {
    if docker ps -q -f status=running -f name="$1"; then
        echo ":: Stopping running container - $1"
        docker stop "$1"
    fi
}

function parse_arguments() {
    while [ $# -gt 0 ]; do
        local opt="$1"
        shift
        case "${opt}" in
            build)
                docker build -f $DOCKERFILE -t $IMAGE_NAME .
                ;;
        esac
    done
}

function main() {
    parse_arguments "$@"
    
    stop_container ${DEV_CONTAINER}
    rm_container ${DEV_CONTAINER}
    
    docker run -itd \
           --net=monitoring \
           -v ${PWD}:${DEV_CONTAINER_WORKDIR} \
           -v /var/run/docker.sock:/var/run/docker.sock \
           --name $DEV_CONTAINER \
           $IMAGE_NAME
}

main "$@"
