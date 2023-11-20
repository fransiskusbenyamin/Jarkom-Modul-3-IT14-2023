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

```
apt update && apt-get install dnsutils -y
dig riegel.canyon.it25.com
dig granz.channel.it25.com 
```


## No 2-5
> Semua CLIENT harus menggunakan konfigurasi dari DHCP Server.
*Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32 dan [prefix IP].3.64 - [prefix IP].3.80 (2)
 Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20 dan [prefix IP].4.160 - [prefix IP].4.168 (3)
 Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut (4)
 Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3 selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit (5)
 
langsung jalankan setup.sh pada Himmel 

Tes:

Buka salah satu node klien (Sein, Start, Revolte, Richter). Seharusnya, saat pertama kali dibuka, klien harus memperoleh alamat IP seperti contoh berikut:

```
udhcpc: started, v1.30.1
udhcpc: sending discover
udhcpc: sending select for 192.240.4.14
udhcpc: lease of 192.240.4.14 obtained, lease time 720
```

Artinya, klien telah berhasil mendapatkan alamat IP secara otomatis (DHCP berfungsi).

Jika pada modul sebelumnya kita menetapkan nameserver 192.168.122.1 pada setiap node untuk dapat terhubung ke internet, untuk pertanyaan nomor 4, kita diminta untuk menetapkan IP dari Heiter, yaitu 192.168.1.3, pada setiap klien DHCP. Hal ini hanya perlu dimasukkan ke dalam konfigurasi sebelumnya:


option domain-name-servers 192.240.1.3;
 
Namun, jangan lupa untuk mengonfigurasi Heiter agar dapat meneruskan ke nameserver yang biasanya dilakukan dengan skrip BIND 9 berikut:

```
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
```


Untuk memeriksa konfigurasi, buka klien dan ketik:
```
`cat /etc/resolv.conf`
```
output:

```
root@Stark:/# cat /etc/resolv.conf
nameserver 192.240.1.3
```

Ini menunjukkan bahwa nameserver telah terdaftar.

Selanjutnya, waktu sewa dapat dilihat dalam pengaturan server DHCP sebelumnya:


default-lease-time 180; # 3 menit dalam detik
max-lease-time 5760;    # 96 menit dalam detik

default-lease-time 720; # 12 menit dalam detik
max-lease-time 5760;    # 96 menit dalam detik



Jika membuka klien, maka:

```
udhcpc: started, v1.30.1
udhcpc: sending discover
udhcpc: sending select for 192.240.4.14
udhcpc: lease of 192.240.4.14 obtained, lease time 720
```


## No 6
>Pada masing-masing worker PHP, lakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3. (6)

Padaa setiap worker PHP di lakukan konfigurasi gunakan script setup.sh pada phpWorker


laukan testing pada setiap worker

test
```
`curl localhost`
```
outputnya akan berupa file html dari file yg sudah di download

>Kepala suku dari Bredt Region memberikan resource server sebagai berikut:
Lawine, 4GB, 2vCPU, dan 80 GB SSD.
Linie, 2GB, 2vCPU, dan 50 GB SSD.
Lugner 1GB, 1vCPU, dan 25 GB SSD.
aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000 request dan 100 request/second. (7)

Tidak secara langsung, pertanyaan ini meminta kita untuk mengonfigurasi Elsen sebagai Load Balancer. Cukup jalankan skrip setup6-7.sh yang berisi konfigurasi tiga load balancer dengan tiga algoritma yang berbeda: Round Robin, Least Connection, dan IP Hash. Setelah itu, jalankan pengujian di Elsen dengan perintah:

```
curl localhost:81                # Untuk Algoritma Round Robin
curl localhost:82                # Least Connection
curl localhost:83                # IP Hash
```

Masuk ke Client lakukan instalasi dengan perintah berikut:

```
apt-get update
apt-get install apache2-utils -y
```


Selanjutnya, untuk melakukan pengujian dengan 1000 permintaan dan 100 permintaan per detik, gunakan perintah berikut:
```
`ab -n 1000 -c 100 -k http://192.240.2.2:81/
`
```
![image](https://user-images.githubusercontent.com/76695790/284225471-babcea69-4071-47a3-8375-c1a1659f31e7.png)

## No 8
>Karena diminta untuk menuliskan grimoire, buatlah analisis hasil testing dengan 200 request dan 10 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut:
Nama Algoritma Load Balancer
Report hasil testing pada Apache Benchmark
Grafik request per second untuk masing masing algoritma. 
Analisis (8)

untuk command testnya sama 
```
ab -n 200 -c 10 -k http://192.240.2.2:81/             #Round robin
ab -n 200 -c 10 -k http://192.240.2.2:82/             #Least con
ab -n 200 -c 10 -k http://192.240.2.2:83/             #IP Hash
```
Hasil analisisnya bisa dilihat di link berikut 
https://docs.google.com/document/d/1uNq9yQKSiKo7Ih6TIGgbPdEBtnkQ4ohjjDuTmYrWz_g/edit

## No 9
>Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire. (9)

pada bagian 

```
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
```
dan lakukan test seperti biasa sudah ada di grimore
https://docs.google.com/document/d/1uNq9yQKSiKo7Ih6TIGgbPdEBtnkQ4ohjjDuTmYrWz_g/edit

## No 10
>Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi username: “netics” dan password: “ajkyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/rahasisakita/ (10)

untuk apply, masuk ke Elsen lalu run setup.sh dan run no12.sh pada Himmel dan restart client (sein dkk)
```
curl -u netics:ajkit25 localhost:81                  (Pada Elsen)
curl -u netics:ajkti25 192.240.2.2:81                 (pada Sein outputnya harusnya sukses) 
curl -u netics:ajkti25 192.240.2.2:81		(Pada Stark karena IP nya random jadi forbidden)
```

## No 11
>Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju halaman https://www.its.ac.id. (11) hint: (proxy_pass)

```
location /its {
            proxy_pass https://www.its.ac.id;
            rewrite ^/its(.*)$ https://www.its.ac.id$1 permanent;
    }



apt install lynx
curl -u netics:ajkti25 -i 10.72.2.2:81/its 		 (pada Sein outputnya harusnya sukses)
lynx 10.72.2.2:81/its 
```


## No 12
>Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].3.69, [Prefix IP].3.70, [Prefix IP].4.167, dan [Prefix IP].4.168. (12) hint: (fixed in dulu clinetnya)

Pada himmel

```
    hardware ethernet 92:3a:3c:c7:ed:98;
    fixed-address 192.240.3.69;
    option host-name "Revolter";
}

host Sein {
    hardware ethernet ae:70:84:b0:03:11;
    fixed-address 192.240.4.167;
    option host-name "Sein";
}
```

pada Elsen
```
allow 127.0.0.1;
        allow 192.240.3.69;
        allow 192.240.3.70;
        allow 192.240.4.167;
        allow 192.240.4.168;
        deny all;
```
## No 13
Karena para petualang kehabisan uang, mereka kembali bekerja untuk mengatur riegel.canyon.yyy.com.
>Semua data yang diperlukan, diatur pada Denken dan harus dapat diakses oleh Frieren, Flamme, dan Fern.

untuk apply, buka terminal di Denken lalu run setup.sh
```
#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf
apt update && apt install ne -y

# masukan ke ~/.bashrc
echo "echo nameserver 192.168.122.1 > /etc/resolv.conf
apt update && apt install ne -y
" > ~/.bashrc

apt remove --purge *mysql* -y
apt remove --purge *mariadb* -y
rm -rf /etc/mysql /var/lib/mysql
apt autoremove -y
apt autoclean -y

apt-get install mariadb-server -y

service mysql start
```


dan lakukan langkah sesuai notes.txt pada main/Denken (instruksi juga ada di bawah)
```
# ketik command dibawah
mysql 

# ketik di dalam shell mysql
CREATE USER 'kelompokit14'@'%' IDENTIFIED BY 'passwordit14';
CREATE USER 'kelompokit14'@'localhost' IDENTIFIED BY 'passwordit14';
CREATE DATABASE dbkelompokit14;
GRANT ALL PRIVILEGES ON dbkelompokit14.* TO 'kelompokit14'@'%';
GRANT ALL PRIVILEGES ON dbkelompokit14.* TO 'kelompokit14'@'localhost';
FLUSH PRIVILEGES;
SHOW DATABASES;

# setelag selesai 
ctrl - c


mysql -u kelompokit14 -ppasswordit14
SHOW DATABASES;

# ketik
nano /etc/mysql/my.cnf

#tambah baris paling bawah lalu save
[mysqld]
skip-networking=0
skip-bind-address

# ketik
service mysql restart
```

untuk memeriksa apakah database sudah bisa diakses, kita lakukan testing pada terminal salah satu worker laravel (Frieren, Fiamme, atau Fern)
```
mysql --host=192.240.2.3 --port=3306 --user=kelompokit14 --password
```
lalu masukkan passwordnya = passwordit14, dan apabila sudah muncul pesan seperti ini, maka Frieren, Fiamme, dan Fern sudah bisa mengakses data pada database di Denken
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/e3ca9817-7173-41e5-870d-f2577c6f9a56)

## No 14
>Frieren, Flamme, dan Fern memiliki Riegel Channel sesuai dengan quest guide berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer

Pada nomor 14 kita diminta untuk melakukan deploy laman laravel untuk menghandle HTTP Request (register, login, dan me)
untuk itu, kita perlu melakukan beberapa konfigurasi untuk menjalankan laravel server dengan setup sebagai berikut (setup.sh)
```
apt-get update
apt install nginx wget zip htop -y
apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2

# Add Sury.org repository key
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg

# Add Sury.org repository to sources.list
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

apt-get update

apt-get install php8.0-mbstring php8.0-xml php8.0-cli php8.0-common php8.0-intl php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl mariadb-client -y

curl -L --insecure https://getcomposer.org/download/2.0.13/composer.phar -o composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/composer

wget -O '/var/www/jarkom.zip' 'https://github.com/martuafernando/laravel-praktikum-jarkom/archive/refs/heads/main.zip'
unzip -o /var/www/jarkom.zip -d /var/www/
rm /var/www/jarkom.zip

echo '
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=192.240.2.3
DB_PORT=3306
DB_DATABASE=dbkelompokit14
DB_USERNAME=kelompokit14
DB_PASSWORD=passwordit14

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
' > /var/www/laravel-praktikum-jarkom-main/.env

cd /var/www/laravel-praktikum-jarkom-main

composer update
composert insall
php artisan migrate:fresh
php artisan db:seed --class=AiringsTableSeeder
php artisan key:generate
php artisan jwt:secret

cd ~

echo '
 server {

 	listen 8000;

 	root /var/www/laravel-praktikum-jarkom-main/public;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
 	}

    location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/jarkom_error.log;
 	access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/laravel-praktikum-jarkom-main

ln -s --force /etc/nginx/sites-available/laravel-praktikum-jarkom-main /etc/nginx/sites-enabled/laravel-praktikum-jarkom-main

chown -R www-data.www-data /var/www/laravel-praktikum-jarkom-main/storage

rm /etc/nginx/sites-enabled/default

service nginx restart
service php8.0-fpm stop
service php8.0-fpm start
```
setelah menjalankan script ini, kita akan bisa mencoba mengakses server melalui client menggunakan lynx (mari kita coba dari client Sein)
```
lynx http://192.240.4.1:8000/
```
apabila berhasil kita akan dapat melihat layar ini pada terminal client
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/5470f2c8-6e29-4855-805c-93f305101780)

## No 15
Riegel Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second.
>POST /auth/register

Untuk mengirimkan request HTTP kepada server kita perlu membuat file register.json yang akan dikirimkan dalam request POST
```
{
 "username": "kelompokit14",
 "password": "passwordit14"
}
```
Jalankan perintah berikut pada client
```
ab -n 100 -c 10 -p register.json -T application/json http://192.240.4.3:8000/api/auth/register
```
maka kita akan mendapatkan bahwa dari 100 request yang dikirimkan, hanya 1 yang berhasil dikarenakan server tidak memperbolehkan register pengguna dengan username yang sudah dipakai
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/6a17da73-44ad-4484-86e6-8dc514afd7b8)

## No 16
>POST /auth/login 

Sama halnya dengan nomor 15, kita perlu membuat file json untuk dikirimkan pada request HTTP 
```
{
 "username": "kelompokit14",
 "password": "passwordit14"
}
```
Jalankan perintah berikut pada client
```
ab -n 100 -c 10 -p login.json -T application/json http://192.240.4.3:8000/api/auth/login
```
didapati melalui testing sebanyak 100 request, jumlah failed requestnya adalah sekitar 30 an
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/6931787b-e0e7-4eda-a847-e63e816b1915)

## No 17
>GET /me
disini kita ingin mendapatkan hasil testing pada GET /me yang memerlukan Authorization: Bearer Token
Untuk mendapatkan tokennya kita perlu menjalankan ini pada client 
```
curl -X POST -H "Content-Type: application/json" -d @login.json http://192.240.4.3:8000/api/auth/login > login_output.txt
```
Lalu token yang sudah didapatkan dimasukkan ke dalam .token dengan perintah berikut 
```
token=$(cat login_output.txt | jq -r '.token')
```
lalu sesuai dengan perintah, kita juga akan melihat hasil testing dengan 100 request
```
ab -n 100 -c 10 -H "Authorization: Bearer $token" http://192.240.4.3:8000/api/me
```
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/b6b76cad-86dc-4d1f-bd9c-44cbb600a777)

## No 18
>Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur Riegel Channel maka implementasikan Proxy Bind pada Eisen untuk mengaitkan IP dari Frieren, Flamme, dan Fern.

Untuk memastikan loadbalancing berjalan dengan benar, kita melakukan konfigurasi yang terdapat pada bash script ini
```
#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf
apt update && apt install ne -y

# masukan ke ~/.bashrc
echo "echo nameserver 192.168.122.1 > /etc/resolv.conf
apt update && apt install ne -y
" > ~/.bashrc

apt autoremove nginx -y
# instal dependencies

apt install -y lsb-release apt-transport-https ca-certificates wget nginx apache2-utils
service nginx start

mkdir /etc/nginx/rahasisakita

htpasswd -bc /etc/nginx/rahasisakita/htpasswd netics ajkit14
# Mengatur load balancer dengan Round Robin
cat > /etc/nginx/conf.d/load_balancer_round_robin.conf <<EOF
upstream backend_round_robin {
    server 192.240.3.1;
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
            proxy_pass https://www.its.ac.id;
            rewrite ^/its(.*)$ https://www.its.ac.id$1 permanent;
    }
}
EOF

# Mengatur load balancer dengan Least Connection
cat > /etc/nginx/conf.d/load_balancer_least_conn.conf <<EOF
upstream backend_least_conn {
    least_conn;
    server 192.240.3.1;
    server 192.240.3.2;
    server 192.240.3.3;
}

server {
    listen 82;
    location / {
        # Konfigurasi pembatasan akses IP dan berikan juga akses untuk localhost
        allow 127.0.0.1;
        allow 192.240.3.69;
        allow 192.240.3.70;
        allow 192.240.4.167;        
        allow 192.240.4.168;
        deny all;

        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/rahasisakita/htpasswd;
        proxy_pass http://backend_least_conn;
    }

    location /its {
            proxy_pass https://www.its.ac.id;
            rewrite ^/its(.*)$ https://www.its.ac.id$1 permanent;
    }
}
EOF

# Mengatur load balancer dengan IP Hash
cat > /etc/nginx/conf.d/load_balancer_ip_hash.conf <<EOF
upstream backend_ip_hash {
    ip_hash;
    server 192.240.3.1;
    server 192.240.3.2;
    server 192.240.3.3;
}

server {
    listen 83;
    location / {
        # Konfigurasi pembatasan akses IP
        allow 127.0.0.1;
        allow 192.240.3.69;
        allow 192.240.3.70;
        allow 192.240.4.167;
        allow 192.240.4.168;
        deny all;
        
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/rahasisakita/htpasswd;
        proxy_pass http://backend_ip_hash;
    }

    location /its {
            proxy_pass https://www.its.ac.id;
            rewrite ^/its(.*)$ https://www.its.ac.id$1 permanent;
        }
}
EOF

#Mengatur Load balancer untuk Laravel
cat > /etc/nginx/conf.d/load_balancer_laravel.conf <<EOF
upstream backend_least_conn_laravel {
    least_conn;
    server 192.240.4.1:8000;
    server 192.240.4.2:8000;
    server 192.240.4.3:8000;
}

server {
    listen 84;
    location / {
        proxy_pass http://backend_least_conn_laravel;
    }

    location /app1{
        proxy_bind 192.240.4.1;
        proxy_pass http://192.240.4.1:8000/;
        rewrite ^/app1(.*)$ http://192.240.4.1:8000/$1 permanent;
    }

    location /app2{
        proxy_bind 192.240.4.2;
        proxy_pass http://192.240.4.2:8000/;
        rewrite ^/app2(.*)$ http://192.240.4.2:8000/$1 permanent;
    }

    location /app3{
        proxy_bind 192.240.4.3;
        proxy_pass http://192.240.4.3:8000/;
        rewrite ^/app3(.*)$ http://192.240.4.3:8000/$1 permanent;
    }
}
EOF


nginx -t
# Restart Nginx untuk menerapkan konfigurasi
service nginx restart
```
setelah itu kita cek apakah sudah berhasil dengan test dibawah ini
```
ab -n 100 -c 10 -p login.json -T application/json http://riegel.canyon.it14.com/api/auth/login
```
dan hasilnya seperti ini
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/ea68edee-18ee-467f-a7fa-32e8f054bc64)

lalu kita periksa log menggunakan perintah ini
```
cat /var/log/nginx/jarkom_access.log
```
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/231efb62-89ee-48e1-845b-1f904a703955)
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/87fd20da-af68-4cd3-89f2-a42f04d4624b)
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/6e3792ad-9ada-42fe-81f9-fe2e900a338a)

## No 19
>Untuk meningkatkan performa dari Worker, coba implementasikan PHP-FPM pada Frieren, Flamme, dan Fern. Untuk testing kinerja naikkan 
>- pm.max_children
>- pm.start_servers
>- pm.min_spare_servers
>- pm.max_spare_servers
>sebanyak tiga percobaan dan lakukan testing sebanyak 100 request dengan 10 request/second kemudian berikan hasil analisisnya pada Grimoire.
Maka dari ini kita perlu mengganti konfigurasi PHP-FPM dengan nilai-nilai yang lebih tinggi

>pm.max_children:Menentukan jumlah maksimal anak proses PHP-FPM yang dapat dibuat untuk menangani permintaan secara bersamaan.
>pm.start_servers:Menentukan jumlah anak proses PHP-FPM yang akan dibuat saat FPM pertama kali dijalankan atau di-restart.
>pm.min_spare_servers:Menentukan jumlah minimum anak proses yang tetap hidup dan siap menangani permintaan setelah proses FPM dimulai atau restart.
>pm.max_spare_servers:Menentukan jumlah maksimal anak proses yang dapat tetap hidup dan siap menangani permintaan saat beban rendah.

Jalankan script bash ini untuk mengganti value nilai-nilai tersebut
```
#!/bin/bash

# Path to the PHP-FPM pool configuration file
config_file="/etc/php/8.0/fpm/pool.d/www.conf"  # Ganti dengan versi PHP yang sesuai

# Nilai baru untuk menggantikan nilai sebelumnya (disesuaikan dengan keperluan percobaan)
new_max_children=25
new_start_servers=6
new_min_spare_servers=3
new_max_spare_servers=12 

# Backup the original configuration file
cp "$config_file" "$config_file.bak"

# Update the PHP-FPM configuration values
sed -i "s/^pm\.max_children = .*/pm\.max_children = $new_max_children/" "$config_file"
sed -i "s/^pm\.start_servers = .*/pm\.start_servers = $new_start_servers/" "$config_file"
sed -i "s/^pm\.min_spare_servers = .*/pm\.min_spare_servers = $new_min_spare_servers/" "$config_file"
sed -i "s/^pm\.max_spare_servers = .*/pm\.max_spare_servers = $new_max_spare_servers/" "$config_file"

# Restart PHP-FPM to apply changes
service php8.0-fpm restart
```
untuk melakukan testing, dapat menggunakan terminal pada client dengan perintah berikut
```
ab -n 100 -c 10 -p login.json -T application/json http://riegel.canyon.it14.com/api/auth/login 
```
karena diminta untuk melakukan tiga percobaan, akan ada tiga set nilai sebagai berikut dan dengan hasil masing-masing yang berbeda
>Konfigurasi pertama (default)
>-pm.max_children = 5
>-pm.start_servers = 2
>-pm.min_spare_servers = 1
>-pm.max_spare_servers = 3
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/d8299a45-381c-4e89-9a0f-513b442e1b19)

>Konfigurasi kedua
>-pm.max_children = 25
>-pm.start_servers = 6
>-pm.min_spare_servers = 3
>-pm.max_spare_servers = 12
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/28777537-686c-427a-822d-2af21ab7cacb)

>Konfigurasi ketiga
>-pm.max_children = 50
>-pm.start_servers = 10
>-pm.min_spare_servers = 5
>-pm.max_spare_servers = 20
![image](https://github.com/fransiskusbenyamin/Jarkom-Modul-3-IT14-2023/assets/73869671/b22028b5-cc5c-477c-affb-d222b4037210)

## No 20
>Nampaknya hanya menggunakan PHP-FPM tidak cukup untuk meningkatkan performa dari worker maka implementasikan Least-Conn pada Eisen. Untuk testing kinerja dari worker tersebut dilakukan sebanyak 100 request dengan 10 request/second.
>
