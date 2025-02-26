#!/bin/bash
# docker run --rm -it --net=monitoring --name iperf3_server monitoring-telegraf:latest /usr/bin/iperf3 -s
./src/iperf3 -c iperf3_server -t 2 -i 1 -u -b 15m -R -J
