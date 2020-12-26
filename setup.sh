#!/bin/sh

if [ -z ${TARGETPLATFORM+x} ]; then
    echo "TARGETPLATFORM is unset"
    exit 1
else
    echo "TargetPlatform is ${TARGETPLATFORM}"
fi

apk update
apk add jq curl
rm -rf /var/cache/apk/*

case $TARGETPLATFORM in
"linux/amd64") wget 'https://bintray.com/ookla/download/download_file?file_path=ookla-speedtest-1.0.0-x86_64-linux.tgz' -O /tmp/speedtest-cli.tgz ;;
"linux/arm64") wget 'https://bintray.com/ookla/download/download_file?file_path=ookla-speedtest-1.0.0-arm-linux.tgz' -O /tmp/speedtest-cli.tgz ;;
*)
    echo "Unsupported platform $TARGETPLATFORM"
    exit 1
    ;;
esac

mkdir /tmp/speedtest-cli
tar -xzf /tmp/speedtest-cli.tgz -C /tmp/speedtest-cli
cp /tmp/speedtest-cli/speedtest /speedtest
rm /tmp/speedtest* -r

chmod +x /speedtest
chmod +x /entrypoint.sh
chmod +x /speedtest.sh
