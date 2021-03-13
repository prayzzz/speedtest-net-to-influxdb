# speedtest.net to influxdb

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/prayzzz/speedtest-net-to-influxdb/release)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/prayzzz/speedtest-net-to-influxdb?sort=semver)](https://hub.docker.com/r/prayzzz/speedtest-net-to-influxdb)

Uses the offical http://speedtest.net cli to perform speedtests periodically and posts the results to influxdb.

Heavily inspired by [Caroga/speedtest-to-influxdb](https://github.com/Caroga/speedtest-to-influxdb)

Download and upload are written as `bits` to influxdb.

`prayzzz/speedtest-net-to-influxdb:2021.02.26.1931` is the last version to support InfluxDB 1.8

## environment variables
- INTERVAL (in seconds)
- HOST (current hostname used as influxdb tag)
- INFLUXDB_URL
- INFLUXDB_ORG
- INFLUXDB_BUCKET
- INFLUXDB_TOKEN

## docker-compose

```yaml
version: "3"

services:
  speedtest:
    image: prayzzz/speedtest-net-to-influxdb:latest
    environment:
      - INTERVAL=60
      - HOST=myhost
      - INFLUXDB_URL=http://myinfluxdb.local
      - INFLUXDB_ORG=...
      - INFLUXDB_BUCKET=...
      - INFLUXDB_TOKEN=...
```