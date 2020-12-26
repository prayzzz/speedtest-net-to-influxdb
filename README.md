# speedtest.net to influxdb

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/prayzzz/speedtest-net-to-influxdb/release)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/prayzzz/speedtest-net-to-influxdb?sort=semver)](https://hub.docker.com/r/prayzzz/speedtest-net-to-influxdb)

Uses the offical http://speedtest.net cli to perform speedtests periodically and posts the results to influxdb.

Heavily inspired by [Caroga/speedtest-to-influxdb](https://github.com/Caroga/speedtest-to-influxdb)

## environment variables
- INTERVAL (in seconds)
- INFLUXDB_HOST
- INFLUXDB_NAME

## docker-compose

```yaml
version: "3"

services:
  speedtest:
    image: prayzzz/speedtest-net-to-influxdb:latest
    environment:
      - INTERVAL=60
      - INFLUXDB_HOST=http://myinfluxdb.local
      - INFLUXDB_NAME=my-database
```