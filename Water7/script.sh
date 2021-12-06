echo -e "192.215.0.10\neth0 eth1 eth2\n" | apt install isc-dhcp-relay -y
bash iptables.sh
dhcrelay 192.215.0.10