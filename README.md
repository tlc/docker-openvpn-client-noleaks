
# OpenVPN

Yet another OpenVPN client docker container.

Features:
 * For use by other containers with --net=container:openvpn.
 * No DNS leaks -- DNS is via the tunnel.
 * No IP leaks -- If openvpn dies, the connected containers will not route beyond the local LAN.

# How to build this image

    docker build -t troyc/openvpn .

# How to use this image

This OpenVPN container was designed to be started first to provide a connection
to other containers (using `--net=container:openvpn`, see below).

**NOTE**: OpenVPN requires certain privileges.
You must use the `--cap-add=NET_ADMIN` and `--device /dev/net/tun` options.

## Hosting an OpenVPN client instance

Copy your vpn.conf (and certificate file, if separate) to /some/path

    docker run --cap-add=NET_ADMIN --device /dev/net/tun --name openvpn
                -v /some/path:/vpn -d troyc/openvpn

Once it's up, other containers can be started using it's network connection:

    docker run --net=container:openvpn -d some/docker-container

### Timezone

If you care about the times shown in the logs, you can use

            -v /etc/timezone:/etc/timezone:ro

### VPN configuration

You must provide a VPN configuration and certificate.
Put your VPN configuration in /some/path/vpn.conf.
If your certificate is not embedded, place it in `/some/path/some_cert_file`
and reference `some_cert_file` in your `vpn.conf`.

    docker run --cap-add=NET_ADMIN --device /dev/net/tun --name openvpn \
                -v /some/path:/vpn -d troyc/openvpn 

