;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     jarkom-t08.com. root.jarkom-t08.com. (
                     2021100401         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@               IN      NS      jarkom-t08.com.
@               IN      A       192.215.0.11