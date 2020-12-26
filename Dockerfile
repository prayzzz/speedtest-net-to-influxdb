FROM alpine:3.12.3

ARG TARGETPLATFORM

COPY setup.sh /setup.sh
COPY entrypoint.sh /entrypoint.sh
COPY speedtest.sh /speedtest.sh

RUN chmod +x /setup.sh && /setup.sh

ENTRYPOINT ["/entrypoint.sh"]
