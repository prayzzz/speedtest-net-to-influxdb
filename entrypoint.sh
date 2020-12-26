#!/bin/sh

if [ -z ${INTERVAL+x} ]; then
    echo "INTERVAL is unset"
    exit 1
else
    echo "Interval is ${INTERVAL}"
fi

if [ -z ${INFLUXDB_URL+x} ]; then
    echo "INFLUXDB_URL is unset"
    exit 1
else
    echo "InfluxDB URL is ${INFLUXDB_URL}"
fi

if [ -z ${INFLUXDB_NAME+x} ]; then
    echo "INFLUXDB_NAME is unset"
    exit 1
else
    echo "InfluxDB Name is ${INFLUXDB_NAME}"
fi

echo ""

./speedtest.sh
