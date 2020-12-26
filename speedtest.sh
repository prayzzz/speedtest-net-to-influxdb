#!/bin/sh

while true; do

    echo "Starting speedtest"

    JSON=$(./speedtest --accept-license --accept-gdpr -f json)

    TIMESTAMP=$(echo $JSON | jq '.timestamp' -r)

    ISP_NAME=$(echo $JSON | jq '.isp' -r)
    INTERNAL_IP=$(echo $JSON | jq '.interface.internalIp' -r)
    EXTERNAL_IP=$(echo $JSON | jq '.interface.externalIp' -r)

    PING=$(echo $JSON | jq '.ping.latency' -r)
    DOWNLOAD=$(echo $JSON | jq '.download.bandwidth' -r)
    UPLOAD=$(echo $JSON | jq '.upload.bandwidth' -r)

    SERVER_ID=$(echo $JSON | jq '.server.id' -r)
    SERVER_NAME=$(echo $JSON | jq '.server.name' -r)
    SERVER_LOCATION=$(echo $JSON | jq '.server.location' -r)
    SERVER_COUNTRY=$(echo $JSON | jq '.server.country' -r)
    SERVER_IP=$(echo $JSON | jq '.server.ip' -r)

    RESULT_LINK=$(echo $JSON | jq '.result.url' -r)

    echo "Results at $TIMESTAMP"
    echo "            ISP: $ISP_NAME"
    echo "    Internal IP: $INTERNAL_IP"
    echo "    External IP: $EXTERNAL_IP"
    echo "           Ping: $PING"
    echo "       Download: $DOWNLOAD"
    echo "         Upload: $UPLOAD"
    echo "    Server Name: $SERVER_NAME"
    echo "Server Location: $SERVER_LOCATION"
    echo " Server Country: $SERVER_COUNTRY"
    echo "        Results: $RESULT_LINK"

    QUERY='speedtest,host='${HOST}',isp='${ISP_NAME}',internal_ip='${INTERNAL_IP}',external_ip='${EXTERNAL_IP}',server_id='${server_id}',server_name='${SERVER_NAME}',server_location='${SERVER_LOCATION}',server_country='${SERVER_COUNTRY}',server_ip='${SERVER_IP}' download='${DOWNLOAD}',upload='${UPLOAD}',ping='${PING}
    echo "${QUERY}" >/tmp/postdata

    echo ''
    curl -sS -XPOST "${INFLUXDB_URL}/write?db=${INFLUXDB_NAME}" --data-binary @/tmp/postdata
    echo ''

    sleep $INTERVAL

done
