# Jarkom-Modul-5-T08-2021

Laporan Resmi Praktikum Jarkom Modul 5

Disusun oleh :
* Clarissa Fatimah (05311940000012)
* Alessandro Tionardo (05311940000018)
* Christoper Adrian Kusuma (05311940000022)

---
### Topologi

![image](images/1.1.png)
```
Keterangan : 	

Doriki adalah DNS Server
Jipangu adalah DHCP Server
Maingate dan Jorge adalah Web Server
Jumlah Host pada Blueno adalah 100 host
Jumlah Host pada Cipher adalah 700 host
Jumlah Host pada Elena adalah 300 host
Jumlah Host pada Fukurou adalah 200 host
```


Karena kalian telah belajar subnetting dan routing, Luffy ingin meminta kalian untuk membuat topologi tersebut menggunakan teknik CIDR atau VLSM. setelah melakukan subnetting, Kalian juga diharuskan melakukan Routing agar setiap perangkat pada jaringan tersebut dapat terhubung.

![image](images/vlsm.png)

menghitung pembagian IP berdasarkan NID dan netmask seperti gambar. Kemudian dilakukan subnetting untuk pembagian IP sesuai subnet yang ada.

![image](images/tree.png)

tabel subnet dapat dilihat pada tabel berikut.

![image](images/subnet.png)

Kami dapatkan hasil perhitungan Network ID, Netmask, Broadcast Address dari semua subnet pada tabel berikut.

![image](images/broadcast.png)

# Soal 

## 1. Agar topologi yang kalian buat dapat mengakses keluar, kalian diminta untuk mengkonfigurasi Foosha menggunakan iptables, tetapi Luffy tidak ingin menggunakan MASQUERADE.

### foosha 

konfigurasi foosha
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.215.0.1
	netmask 255.255.255.252
	broadcast 192.215.0.3

auto eth2
iface eth2 inet static
	address 192.215.0.5
	netmask 255.255.255.252
	broadcast 192.215.0.7
```


## 2. Kalian diminta untuk mendrop semua akses HTTP dari luar Topologi kalian pada server yang merupakan DHCP Server dan DNS Server demi menjaga keamanan.

pada foosha
```
iptables -A FORWARD -d 192.215.0.16/29 -i eth0 -p tcp -m tcp --dport 80 -j DROP
```

Menggunakan -A FORWARD FORWARD chain untuk menyaring paket dengan -p tcp -m tcp protokol TCP dari luar topologi menuju ke DHCP Server JIPANGU dan DNS Server DORIKI dengan menggunakan subnet yang sama, dimana akses HTTP (yang memiliki --dport 80 port 80) yang masuk ke DHCP Server JIPANGU dan DNS Server DORIKI melalui -i eth0 interfaces eth0 dari DHCP Server JIPANGU dan DNS Server DORIKI agar -j DROP di DROP

## 3. Karena kelompok kalian maksimal terdiri dari 3 orang. Luffy meminta kalian untuk membatasi DHCP dan DNS Server hanya boleh menerima maksimal 3 koneksi ICMP secara bersamaan menggunakan iptables, selebihnya didrop.

pada jipangu 
```
iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
```
pada doriki
```
iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
```

menggunakan -A INPUT INPUT chain untuk menyaring paket dengan -p icmp agar protokol ICMP atau ping yang masuk agar dibatasi -m connlimit --connlimit-above 3 hanya sebatas maksimal 3 koneksi saja --connlimit-mask 0 darimana saja, sehingga lebih dari itu akan -j DROP di DROP

## 4. Akses dari subnet Blueno dan Cipher hanya diperbolehkan pada pukul 07.00 - 15.00 pada hari Senin sampai Kamis.[membatasi akses ke Doriki]

pada Water7
```
# Blueno -> Doriki
iptables -A FORWARD -s 192.215.0.128/25 -d 192.215.0.11 -m time --weekdays Mon,Tue,Wed,Thu --timestart 00:00 --timestop 06:59 -j REJECT
iptables -A FORWARD -s 192.215.0.128/25 -d 192.215.0.11 -m time --weekdays Mon,Tue,Wed,Thu --timestart 15:01 --timestop 23:59 -j REJECT
iptables -A FORWARD -s 192.215.0.128/25 -d 192.215.0.11 -m time --weekdays Fri,Sat,Sun -j REJECT

# Cipher -> Doriki
iptables -A FORWARD -s 192.215.4.0/22 -d 192.215.0.11 -m time --weekdays Mon,Tue,Wed,Thu --timestart 00:00 --timestop 06:59 -j REJECT
iptables -A FORWARD -s 192.215.4.0/22 -d 192.215.0.11 -m time --weekdays Mon,Tue,Wed,Thu --timestart 15:01 --timestop 23:59 -j REJECT
iptables -A FORWARD -s 192.215.4.0/22 -d 192.215.0.11 -m time --weekdays Fri,Sat,Sun -j REJECT
```
Kita menggunakan iptables `-A FOWARD` foward chain pada router water7 untuk menyaring paket dari blueno dan cipher yang melewati router Water7 menuju ke Doriki agar ditolak dan diberikan error message jika berada pada waktu diluar pukul 07.00-15.00 pada hari senin sampai kamis.

**Blueno[success]**

![Soal 4-1](images/4_1.png)

**Blueno[error]**

![Soal 4-2](images/4_2.png)

**Cipher[success]**

![Soal 4-3](images/4_3.png)

**Cipher[error]**

![Soal 4-4](images/4_4.png)

## 5. Akses dari subnet Elena dan Fukuro hanya diperbolehkan pada pukul 15.01 hingga pukul 06.59 setiap harinya.[membatasi akses ke Doriki]

pada Foosha

```
# Elena -> Doriki
iptables -A FORWARD -s 192.215.2.0/23 -d 192.215.0.11 -m time --timestart 07:00 --timestop 15:00 -j REJECT

# Fukuro -> Doriki
iptables -A FORWARD -s 192.215.1.0/24 -d 192.215.0.11 -m time --timestart 07:00 --timestop 15:00 -j REJECT
```

Kita menggunakan iptables `-A FOWARD` foward chain pada router Foosha untuk menyaring paket dari Elena dan Fukuro yang melewati router Foosha menuju ke Doriki agar ditolak dan diberikan error message jika berada pada waktu diluar pukul 15.01 hingga pukul 06.59 setiap harinya.

**Elena[success]**

![Soal 5-1](images/5_1.png)

**Elena[error]**

![Soal 5-2](images/5_2.png)

**Fukurou[success]**

![Soal 5-3](images/5_3.png)

**Fukurou[error]**

![Soal 5-4](images/5_4.png)

## 6. Karena kita memiliki 2 Web Server, Luffy ingin Guanhao disetting sehingga setiap request dari client yang mengakses DNS Server akan didistribusikan secara bergantian pada Jorge dan Maingate

pada Guanhao

```
iptables -t nat -A PREROUTING -p tcp -d 192.215.0.11 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.215.0.18:80
iptables -t nat -A PREROUTING -p tcp -d 192.215.0.11 -m statistic --mode nth --every 1 --packet 0 -j DNAT --to-destination 192.215.0.19:80
```

Pada kasus ini kita menggunakan solusi Load Balancing untuk mendistribusikan koneksi. Untuk mengatasi masalah ini, kita menggunakan `-A PREROUTING` PREROUTING chain pada  `-t nat` NAT table untuk mengubah destination IP yang awalnya menuju ke 192.215.0.11 DNS Server Doriki menjadi ke 192.215.0.19/29  Server Jorge port 80 dan 192.215.0.18/29 Server Maingate port 80. Iptables ini juga menyertakan salah satu modul yang ada dalam aturan Load Balancing yaitu -m statistic modul statistik.

**Pada Elena**

![Soal 6-1](images/6_1.png)

![Soal 6-2](images/6_2.png)

![Soal 6-2](images/6_3.png)
