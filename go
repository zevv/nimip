#!/bin/sh

sudo ip tuntap add mode tap dev nimtap0
sudo ip addr add 10.3.3.3/24 dev nimtap0
sudo ip link set dev nimtap0 up

