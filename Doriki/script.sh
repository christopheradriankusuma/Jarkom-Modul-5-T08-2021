echo nameserver 192.168.122.1 > /etc/resolv.conf
apt install bind9 unzip -y
unzip -o -d /etc bind.zip
service bind9 restart