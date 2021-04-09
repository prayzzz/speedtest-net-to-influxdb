#!/bin/sh

while true; do

    CMD="./speedtest --accept-license --accept-gdpr --format json"
    if [ ! -z ${SPEEDTEST_SERVER_ID+x} ]; then
        CMD=$CMD" --server-id="$SPEEDTEST_SERVER_ID
    fi

    echo "Starting speedtest with command"
    echo "$CMD"
    echo ""

    JSON=$($CMD)

    TIMESTAMP=$(echo $JSON | jq '.timestamp' -r)

    ISP_NAME=$(echo $JSON | jq '.isp' -r)
    INTERNAL_IP=$(echo $JSON | jq '.interface.internalIp' -r)
    EXTERNAL_IP=$(echo $JSON | jq '.interface.externalIp' -r)

    PING=$(echo $JSON | jq '.ping.latency' -r)
    DOWNLOAD=$(($(echo $JSON | jq '.download.bandwidth' -r) * 8))
    UPLOAD=$(($(echo $JSON | jq '.upload.bandwidth' -r) * 8))
    PACKETLOSS=$(echo $JSON | jq '.packetLoss' -r)

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
    echo "       Download: $DOWNLOAD bps"
    echo "         Upload: $UPLOAD bps"
    echo "     Packetloss: $PACKETLOSS%"
    echo "      Server ID: $SERVER_ID"
    echo "    Server Name: $SERVER_NAME"
    echo "Server Location: $SERVER_LOCATION"
    echo " Server Country: $SERVER_COUNTRY"
    echo "        Results: $RESULT_LINK"

    QUERY='speedtest'
    QUERY=$QUERY',host="'${HOST}'"'
    QUERY=$QUERY' isp="'${ISP_NAME}'"'
    QUERY=$QUERY',internal_ip="'${INTERNAL_IP}'"'
    QUERY=$QUERY',external_ip="'${EXTERNAL_IP}'"'
    QUERY=$QUERY',server_id='${SERVER_ID}
    QUERY=$QUERY',server_name="'${SERVER_NAME}'"'
    QUERY=$QUERY',server_location="'${SERVER_LOCATION}'"'
    QUERY=$QUERY',server_country="'${SERVER_COUNTRY}'"'
    QUERY=$QUERY',server_ip="'${SERVER_IP}'"'
    QUERY=$QUERY',download='${DOWNLOAD}
    QUERY=$QUERY',upload='${UPLOAD}
    QUERY=$QUERY',ping='${PING}

    if [ $PACKETLOSS != 'null' ]; then
        QUERY=$QUERY',packetloss='$PACKETLOSS
    fi

    echo ''
    echo $QUERY

    echo "$QUERY" >/tmp/postdata

    echo ''
    curl -sS -XPOST "${INFLUXDB_URL}/api/v2/write?org=${INFLUXDB_ORG}&bucket=${INFLUXDB_BUCKET}&precision=s" --header "Authorization: Token ${INFLUXDB_TOKEN}" --data-binary @/tmp/postdata
    echo ''

    sleep $INTERVAL

done
