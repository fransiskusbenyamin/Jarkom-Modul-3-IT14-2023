# Jarkom-Modul-3-IT14-2023
Laporan Resmi Praktikum Komunikasi Data dan Jaringan Komputer - Modul 3 - Kelompok IT 14

# Modul 3 Jarkom IT14
* Moh. Sulthan Arief Rahmatullah		5027211045
* Fransiskus Benyamin Sitompul		5027211021


## Pre-Requiresite
Lakukan konfigurasi topologi sebagai berikut
![image](https://user-images.githubusercontent.com/76695790/284220574-de7a7a77-3c2e-4c98-8204-f6dd4e08435c.png)

karena disini kelompok saya mendapat predik 192.240.x.x jadi harus di sesuaikan

## No 0
>Setelah mengalahkan Demon King, perjalanan berlanjut. Kali ini, kalian diminta untuk melakukan register domain berupa riegel.canyon.yyy.com untuk worker Laravel dan granz.channel.yyy.com untuk worker PHP (0) mengarah pada worker yang memiliki IP [prefix IP].x.1.

Lakukan konfigurasi DHCP relay terlebih dahulu pada perangkat Aura menggunakan skrip setup.sh. Setelah itu, lanjutkan dengan melakukan konfigurasi DHCP server pada perangkat Himmel menggunakan skrip setup6-7.sh, karena konfigurasi ini diperlukan untuk keperluan benchmarking pada pertanyaan nomor 7, 8, dan 9.

Selanjutnya, untuk pertanyaan nomor 0, lakukan registrasi domain pada perangkat Heiter menggunakan skrip setup.sh.


test:
Untuk test masuk ke salah satu clien contohnya Richter

command:


apt update && apt-get install dnsutils -y
dig riegel.canyon.it25.com
dig granz.channel.it25.com 



## No 2-5
> Semua CLIENT harus menggunakan konfigurasi dari DHCP Server.
*Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32 dan [prefix IP].3.64 - [prefix IP].3.80 (2)
 Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20 dan [prefix IP].4.160 - [prefix IP].4.168 (3)
 Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut (4)
 Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3 selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit (5)
 
langsung jalankan setup.sh pada Himmel 

Tes:

Buka salah satu node klien (Sein, Start, Revolte, Richter). Seharusnya, saat pertama kali dibuka, klien harus memperoleh alamat IP seperti contoh berikut:


udhcpc: started, v1.30.1
udhcpc: sending discover
udhcpc: sending select for 192.240.4.14
udhcpc: lease of 192.240.4.14 obtained, lease time 720


Artinya, klien telah berhasil mendapatkan alamat IP secara otomatis (DHCP berfungsi).

Jika pada modul sebelumnya kita menetapkan nameserver 192.168.122.1 pada setiap node untuk dapat terhubung ke internet, untuk pertanyaan nomor 4, kita diminta untuk menetapkan IP dari Heiter, yaitu 192.168.1.3, pada setiap klien DHCP. Hal ini hanya perlu dimasukkan ke dalam konfigurasi sebelumnya:


option domain-name-servers 192.240.1.3;
 
Namun, jangan lupa untuk mengonfigurasi Heiter agar dapat meneruskan ke nameserver yang biasanya dilakukan dengan skrip BIND 9 berikut:


options {
    listen-on { 192.240.1.3; };  # IP Heiter
    listen-on-v6 { none; };
    directory "/var/cache/bind";

    # Forwarders
    forwarders {
        192.168.122.1;
    };

    # Jika tidak ada jawaban dari forwarders, jangan mencoba untuk menyelesaikan secara rekursif
    forward only;

    dnssec-validation no;

    auth-nxdomain no;    # sesuai dengan RFC1035
    allow-query { any; };
};



Untuk memeriksa konfigurasi, buka klien dan ketik:

`cat /etc/resolv.conf`

output:


root@Stark:/# cat /etc/resolv.conf
nameserver 192.240.1.3


Ini menunjukkan bahwa nameserver telah terdaftar.

Selanjutnya, waktu sewa dapat dilihat dalam pengaturan server DHCP sebelumnya:


default-lease-time 180; # 3 menit dalam detik
max-lease-time 5760;    # 96 menit dalam detik

default-lease-time 720; # 12 menit dalam detik
max-lease-time 5760;    # 96 menit dalam detik



Jika membuka klien, maka:


udhcpc: started, v1.30.1
udhcpc: sending discover
udhcpc: sending select for 192.240.4.14
udhcpc: lease of 192.240.4.14 obtained, lease time 720



## No 6
>Pada masing-masing worker PHP, lakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3. (6)

Padaa setiap worker PHP di lakukan konfigurasi gunakan script setup.sh pada phpWorker


laukan testing pada setiap worker

test

`curl localhost`

outputnya akan berupa file html dari file yg sudah di download

>Kepala suku dari Bredt Region memberikan resource server sebagai berikut:
Lawine, 4GB, 2vCPU, dan 80 GB SSD.
Linie, 2GB, 2vCPU, dan 50 GB SSD.
Lugner 1GB, 1vCPU, dan 25 GB SSD.
aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000 request dan 100 request/second. (7)

Tidak secara langsung, pertanyaan ini meminta kita untuk mengonfigurasi Elsen sebagai Load Balancer. Cukup jalankan skrip setup6-7.sh yang berisi konfigurasi tiga load balancer dengan tiga algoritma yang berbeda: Round Robin, Least Connection, dan IP Hash. Setelah itu, jalankan pengujian di Elsen dengan perintah:


curl localhost:81                # Untuk Algoritma Round Robin
curl localhost:82                # Least Connection
curl localhost:83                # IP Hash


Masuk ke Client lakukan instalasi dengan perintah berikut:


apt-get update
apt-get install apache2-utils -y



Selanjutnya, untuk melakukan pengujian dengan 1000 permintaan dan 100 permintaan per detik, gunakan perintah berikut:

`ab -n 1000 -c 100 -k http://192.240.2.2:81/
`

![image](https://user-images.githubusercontent.com/76695790/284225471-babcea69-4071-47a3-8375-c1a1659f31e7.png)

## No 8
>Karena diminta untuk menuliskan grimoire, buatlah analisis hasil testing dengan 200 request dan 10 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut:
Nama Algoritma Load Balancer
Report hasil testing pada Apache Benchmark
Grafik request per second untuk masing masing algoritma. 
Analisis (8)

untuk command testnya sama 

ab -n 200 -c 10 -k http://192.240.2.2:81/             #Round robin
ab -n 200 -c 10 -k http://192.240.2.2:82/             #Least con
ab -n 200 -c 10 -k http://192.240.2.2:83/             #IP Hash

Hasil analisisnya bisa dilihat di link berikut 
https://docs.google.com/document/d/1uNq9yQKSiKo7Ih6TIGgbPdEBtnkQ4ohjjDuTmYrWz_g/edit

## No 9
>Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire. (9)

pada bagian 


upstream backend_round_robin {
    server 192.240.3.1; <-------- di comment saja untuk 1 worker 2 worker dan 3 worker
    server 192.240.3.2;
    server 192.240.3.3;
}

server {
    listen 81;

    location / {
        # Konfigurasi pembatasan akses IP
        allow 127.0.0.1;
        allow 192.240.3.69;
        allow 192.240.3.70;
        allow 192.240.4.167;
        allow 192.240.4.168;
        deny all;

        # auth
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/rahasisakita/htpasswd;
        proxy_pass http://backend_round_robin;
    }

    location /its {
            rewrite ^/its(.*)$ https://www.its.ac.id$1 permanent;
    }
}

dan lakukan test seperti biasa sudah ada di grimore
https://docs.google.com/document/d/1uNq9yQKSiKo7Ih6TIGgbPdEBtnkQ4ohjjDuTmYrWz_g/edit

## No 10
>Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi username: “netics” dan password: “ajkyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/rahasisakita/ (10)

untuk apply, masuk ke Elsen lalu run setup.sh dan run no12.sh pada Himmel dan restart client (sein dkk)

curl -u netics:ajkit25 localhost:81                  (Pada Elsen)
curl -u netics:ajkti25 192.240.2.2:81                 (pada Sein outputnya harusnya sukses) 
curl -u netics:ajkti25 192.240.2.2:81		(Pada Stark karena IP nya random jadi forbidden)


## No 11
>Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju halaman https://www.its.ac.id. (11) hint: (proxy_pass)


location /its {
            proxy_pass https://www.its.ac.id;
            rewrite ^/its(.*)$ https://www.its.ac.id$1 permanent;
    }



apt install lynx
curl -u netics:ajkti25 -i 10.72.2.2:81/its 		 (pada Sein outputnya harusnya sukses)
lynx 10.72.2.2:81/its 



## No 12
>Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].3.69, [Prefix IP].3.70, [Prefix IP].4.167, dan [Prefix IP].4.168. (12) hint: (fixed in dulu clinetnya)

Pada himmel


    hardware ethernet 92:3a:3c:c7:ed:98;
    fixed-address 192.240.3.69;
    option host-name "Revolter";
}

host Sein {
    hardware ethernet ae:70:84:b0:03:11;
    fixed-address 192.240.4.167;
    option host-name "Sein";
}


pada Elsen

allow 127.0.0.1;
        allow 192.240.3.69;
        allow 192.240.3.70;
        allow 192.240.4.167;
        allow 192.240.4.168;
        deny all;
