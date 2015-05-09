FROM ubuntu:14.04
MAINTAINER Troy Cauble <troycauble@gmail.com>

RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends openvpn \
                $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY bin/update-resolv-conf /etc/openvpn/

VOLUME ["/vpn"]

ENTRYPOINT [ "openvpn", "--config", "/vpn/vpn.conf", "--script-security", "2", "--up", "/etc/openvpn/update-resolv-conf", "--down", "/etc/openvpn/update-resolv-conf" ]
