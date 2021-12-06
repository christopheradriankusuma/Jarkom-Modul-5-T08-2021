# internet
iptables -t nat -A POSTROUTING -s 192.215.0.8/29 -j SNAT --to-source 192.168.122.97
iptables -t nat -A POSTROUTING -s 192.215.0.0/30 -j SNAT --to-source 192.168.122.97
iptables -t nat -A POSTROUTING -s 192.215.4.0/22 -j SNAT --to-source 192.168.122.97
iptables -t nat -A POSTROUTING -s 192.215.0.128/25 -j SNAT --to-source 192.168.122.97
iptables -t nat -A POSTROUTING -s 192.215.0.4/30 -j SNAT --to-source 192.168.122.97
iptables -t nat -A POSTROUTING -s 192.215.2.0/23 -j SNAT --to-source 192.168.122.97
iptables -t nat -A POSTROUTING -s 192.215.1.0/24 -j SNAT --to-source 192.168.122.97
iptables -t nat -A POSTROUTING -s 192.215.0.16/29 -j SNAT --to-source 192.168.122.97

iptables -A FORWARD -p tcp --dport 80 -j DROP ! -s 192.215.0.0/21 -d 192.215.0.8/29

# Elena -> Doriki
iptables -A FORWARD -s 192.215.2.0/23 -d 192.215.0.11 -m time --timestart 07:00 --timestop 15:00 -j REJECT

# Fukuro -> Doriki
iptables -A FORWARD -s 192.215.1.0/24 -d 192.215.0.11 -m time --timestart 07:00 --timestop 15:00 -j REJECT