
# OpenVPN

Yet another OpenVPN client docker container.

Features:
 * For use by other containers with --net=container:openvpn.
 * No DNS leaks -- DNS is via the tunnel.
 * No IP leaks -- If openvpn dies, the connected containers will not route beyond the local LAN.

# How to build this image

You can skip this and pull straight from the docker registry if you like.

    docker build -t troyc/openvpn-client-noleaks .

# How to use this image

**NOTE**: OpenVPN requires certain privileges.
You must use the `--cap-add=NET_ADMIN` and `--device /dev/net/tun` options.

You must provide a VPN configuration and certificate.
Put your VPN configuration in /some/path/vpn.conf.
If your certificate is not embedded, place it in `/some/path/cert_file`
and reference `cert_file` in your `vpn.conf`.

    docker run --cap-add=NET_ADMIN --device /dev/net/tun --name openvpn \
                -v /some/path:/vpn -d troyc/openvpn-client-noleaks 

### Timezone

If you care about the times shown in the logs, you can add

            -v /etc/timezone:/etc/timezone:ro

# Use by Other Containers

Once it's up, other containers can be started using this container's network connection:

    docker run --net=container:openvpn -d some/docker-container


