#!/bin/sh

if [ -z ${INTERVAL+x} ]; then
    echo "INTERVAL is unset"
    exit 1
else
    echo "Interval is ${INTERVAL}"
fi

if [ -z ${INFLUXDB_HOST+x} ]; then
    echo "INFLUXDB_HOST is unset"
    exit 1
else
    echo "InfluxDB Host is ${INFLUXDB_HOST}"
fi

if [ -z ${INFLUXDB_NAME+x} ]; then
    echo "INFLUXDB_NAME is unset"
    exit 1
else
    echo "InfluxDB Name is ${INFLUXDB_NAME}"
fi

echo ""

./speedtest.sh
