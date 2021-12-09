# internet
IP=`ip -br a s eth0 | awk '{print $3}' | awk -F '/' '{print $1}'`
iptables -t nat -A POSTROUTING -s 192.215.0.8/29 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 192.215.0.0/30 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 192.215.4.0/22 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 192.215.0.128/25 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 192.215.0.4/30 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 192.215.2.0/23 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 192.215.1.0/24 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 192.215.0.16/29 -j SNAT --to-source $IP

iptables -A FORWARD -p tcp --dport 80 -j DROP ! -s 192.215.0.0/21 -d 192.215.0.8/29

# Elena -> Doriki
iptables -A FORWARD -s 192.215.2.0/23 -d 192.215.0.11 -m time --timestart 07:00 --timestop 15:00 -j REJECT

# Fukuro -> Doriki
iptables -A FORWARD -s 192.215.1.0/24 -d 192.215.0.11 -m time --timestart 07:00 --timestop 15:00 -j REJECT
