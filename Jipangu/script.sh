echo nameserver 192.168.122.1 > /etc/resolv.conf
apt install isc-dhcp-server unzip -y
unzip -o -d /etc dhcp.zip
unzip -o -d /etc/default isc-dhcp-server.zip
service isc-dhcp-server start