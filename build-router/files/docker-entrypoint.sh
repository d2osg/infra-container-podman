#!/bin/sh
set -e

echo "Container's IP address: `awk 'END{print $1}' /etc/hosts`"

echo 1 > /proc/sys/net/ipv6/conf/all/forwarding

/etc/nftables.conf

