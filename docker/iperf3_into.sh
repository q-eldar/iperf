#!/bin/bash
TARGET_ARCH=$(uname -m)
DEV_CONTAINER="iperf3_client"
function restart_stopped_container {
    if docker ps -q -f status=exited -f name="${DEV_CONTAINER}"; then
        docker start "${DEV_CONTAINER}"
    fi
}

restart_stopped_container

docker exec \
    -it "${DEV_CONTAINER}" \
    /bin/bash
