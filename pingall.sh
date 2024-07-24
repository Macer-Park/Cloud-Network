#!/bin/bash
date
cat list.txt |  while read output
do
    ping -c 1 -W 1 "$output" > /dev/null
    if [ $? -eq 0 ]; then
    echo "host $output is up"
    else
    echo "host $output is down"
    fi
done
