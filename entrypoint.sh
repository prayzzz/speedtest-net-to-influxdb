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

if [ -z ${INFLUXDB_ORG+x} ]; then
    echo "INFLUXDB_ORG is unset"
    exit 1
else
    echo "InfluxDB Organisation is ${INFLUXDB_ORG}"
fi

if [ -z ${INFLUXDB_BUCKET+x} ]; then
    echo "INFLUXDB_BUCKET is unset"
    exit 1
else
    echo "InfluxDB Bucket is ${INFLUXDB_BUCKET}"
fi

if [ -z ${INFLUXDB_TOKEN+x} ]; then
    echo "INFLUXDB_TOKEN is unset"
    exit 1
else
    echo "InfluxDB Token is ${INFLUXDB_TOKEN}"
fi

echo ""

./speedtest.sh
