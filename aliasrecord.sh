#!/bin/bash
echo 'installatie bind9'
sudo apt install -y bind9

echo 'backup named.conf.local'
cp /etc/bind/named.conf.local /etc/bind/named.conf.local_backup

echo 'instellen named.conf.local'
echo 'zone "desireev.com" {
type master;
file "/etc/bind/zones/desireev.com.db";
};
 
zone "3.2.1.in-addr.arpa" {
type master;
file "/etc/bind/zones/rev.3.2.1.in-addr.arpa";
};' >> /etc/bind/named.conf.local


mkdir /etc/bind/zones

echo 'instellen en maken bind/zones/desireev.com.db'
echo '$; BIND data file for desireev.com
;
$TTL 14400
@ IN SOA ns1.desireev.com. host.desireev.com. (
201006601 ; Serial
7200 ; Refresh
120 ; Retry
2419200 ; Expire
604800) ; Default TTL
;
desireev.com. IN NS ns1.desireev.com.
desireev.com. IN NS ns2.desireev.com.
 
desireev.com. IN MX 10 mail.desireev.com.
desireev.com. IN A 192.168.100.11
 
ns1 IN A 192.168.100.11
www IN CNAME desireev.com.
mail IN A 192.168.100.11
ftp IN CNAME desireev.com.
desireev.com. IN TXT "v=spf1 ip4:192.168.100.11 a mx ~all"
mail IN TXT "v=spf1 a -all"' > /etc/bind/zones/desireev.com.db

echo '@ IN SOA desireev.com. host.desireev.com. (
2010081401;
28800;
604800;
604800;
86400 );
 
IN NS ns1.desireev.com.
4 IN PTR desireev.com.
' > /etc/bind/zones/rev.3.2.1.in-addr.arpa

echo 'search desireev.com' >> /etc/resolv.conf

/etc/init.d/bind9 restart