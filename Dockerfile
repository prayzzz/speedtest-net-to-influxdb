FROM alpine:latest

ARG TARGETPLATFORM

COPY setup.sh /setup.sh
COPY entrypoint.sh /entrypoint.sh
COPY speedtest.sh /speedtest.sh

RUN chmod +x /setup.sh && /setup.sh

ENTRYPOINT ["/entrypoint.sh"]
