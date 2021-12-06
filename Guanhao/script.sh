echo nameserver 192.168.122.1 > /etc/resolv.conf
echo -n "192.215.0.10\neth0 eth1\n" | apt install isc-dhcp-relay -y
bash iptables.sh
dhcrelay 192.215.0.10