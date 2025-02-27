#!/bin/bash
# docker run --rm -it --net=monitoring --name iperf3_server monitoring-telegraf:latest /usr/bin/iperf3 -s
./src/iperf3 -c iperf3_server -t 10 -i 2 -u -b 15m -R -J --json-stream
