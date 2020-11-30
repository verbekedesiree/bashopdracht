sudo apt install -y isc-dhcp-server

cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf_backup

cp installdhcp.txt > /etc/dhcp/dhcpd.conf

systemctl restart isc-dhcp-server