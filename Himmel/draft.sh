# Konfigurasi untuk client yang terhubung melalui Switch3
subnet 192.240.3.0 netmask [Netmask] {
    range 192.240.3.16 192.240.3.32;
    range 192.240.3.64 192.240.3.80;
    option routers 192.168.3.1;
    option broadcast-address 192.168.3.255;
    option domain-name-servers 192.240.1.3;
    default-lease-time 180; # 3 menit dalam detik
    max-lease-time 5760; # 96 menit dalam detik
}

# Konfigurasi untuk client yang terhubung melalui Switch4
subnet 192.240.4.0 netmask [Netmask] {
    range 192.240.4.12 192.240.4.20;
    range 192.240.4.160 192.240.4.168;
    option routers 192.168.3.2;
    option broadcast-address 192.168.4.255;
    option domain-name-servers 192.240.1.3;
    default-lease-time 720; # 12 menit dalam detik
    max-lease-time 5760; # 96 menit dalam detik
}
