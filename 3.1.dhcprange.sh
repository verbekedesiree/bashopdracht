cat input_file_dhcp.txt >> /etc/dhcp/dhcpd.conf

systemctl restart isc-dhcp-server