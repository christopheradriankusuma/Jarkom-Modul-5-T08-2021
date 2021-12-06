iptables -A FORWARD -p icmp -j DROP -d 192.215.0.11 -m connlimit --connlimit-above 3 --connlimit-mask 0

# Blueno -> Doriki
iptables -A FORWARD -s 192.215.0.128/25 -d 192.215.0.11 -m time --weekdays Mon,Tue,Wed,Thu --timestart 00:00 --timestop 06:59 -j REJECT
iptables -A FORWARD -s 192.215.0.128/25 -d 192.215.0.11 -m time --weekdays Mon,Tue,Wed,Thu --timestart 15:01 --timestop 23:59 -j REJECT
iptables -A FORWARD -s 192.215.0.128/25 -d 192.215.0.11 -m time --weekdays Fri,Sat,Sun -j REJECT

# Cipher -> Doriki
iptables -A FORWARD -s 192.215.4.0/22 -d 192.215.0.11 -m time --weekdays Mon,Tue,Wed,Thu --timestart 00:00 --timestop 06:59 -j REJECT
iptables -A FORWARD -s 192.215.4.0/22 -d 192.215.0.11 -m time --weekdays Mon,Tue,Wed,Thu --timestart 15:01 --timestop 23:59 -j REJECT
iptables -A FORWARD -s 192.215.4.0/22 -d 192.215.0.11 -m time --weekdays Fri,Sat,Sun -j REJECT