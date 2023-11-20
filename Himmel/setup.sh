echo nameserver 192.168.122.1 > /etc/resolv.conf
apt update && apt install ne -y

# masukan ke ~/.bashrc
echo "echo nameserver 192.168.122.1 > /etc/resolv.conf
apt update && apt install ne -y
" > ~/.bashrc


apt-get install isc-dhcp-server -y

echo '#DHCPDv6_CONF=/etc/dhcp/dhcpd6.conf

# Path to dhcpd PID file (default: /var/run/dhcpd.pid).
#DHCPDv4_PID=/var/run/dhcpd.pid
#DHCPDv6_PID=/var/run/dhcpd6.pid

# Additional options to start dhcpd with.
#       Dont use options -cf or -pf here; use DHCPD_CONF/ DHCPD_PID instead
#OPTIONS=""

# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#       Separate multiple interfaces with spaces, e.g. "eth0 eth1".
INTERFACESv4="eth0"
#INTERFACESv6=""' > /etc/default/isc-dhcp-server

#tambah di paling bawah /etc/dhcp/dhcpd.conf
# Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32 dan [prefix IP].3.64 - [prefix IP].3.80
#Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20 dan [prefix IP].4.160 - [prefix IP].4.168
echo '# Konfigurasi untuk client yang terhubung melalui Switch3
subnet 192.240.3.0 netmask 255.255.255.0 {
    range 192.240.3.16 192.240.3.32; # 16-32
    range 192.240.3.64 192.240.3.80; # 64-80
    option routers 192.240.3.254;
    option broadcast-address 192.240.3.255;
    option domain-name-servers 192.240.1.3; # Ip Heiter
    default-lease-time 180; # 3 menit dalam detik
    max-lease-time 5760; # 96 menit dalam detik
}

# Konfigurasi untuk client yang terhubung melalui Switch4
subnet 192.240.4.0 netmask 255.255.255.0 {
    range 192.240.4.12 192.240.4.20; # 12-20
    range 192.240.4.160 192.240.4.168; # 160-168
    option routers 192.240.4.254;
    option broadcast-address 192.240.4.255;
    option domain-name-servers 192.240.1.3; # Ip Heiter
    default-lease-time 720; # 12 menit dalam detik
    max-lease-time 5760; # 96 menit dalam detik
}

subnet 192.240.1.0 netmask 255.255.255.0 {
    option routers 192.240.1.1;
    option broadcast-address 192.240.1.255;
    option domain-name-servers 192.240.1.3;
}


subnet 192.240.2.0 netmask 255.255.255.0 {
    option routers 192.240.2.1;
    option broadcast-address 192.240.2.255;
    option domain-name-servers 192.240.1.3;
}

' > /etc/dhcp/dhcpd.conf

rm /var/run/dhcpd.pid
# restart dhcp relay
service isc-dhcp-server stop
service isc-dhcp-server start