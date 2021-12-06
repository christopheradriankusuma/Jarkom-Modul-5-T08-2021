echo -e "192.215.0.10\neth2\n" | apt install isc-dhcp-relay -y
bash routing.sh
bash iptables.sh
dhcrelay 192.215.0.10