<h1 align="center" style="font-size:40px;">Apache Auto Setup and Cloudflare Integration</h1>

<p align="center">
  <b>Script bash all-in-one to installing Apache, domain setup, SSL, dan dukungan penuh Cloudflare.</b><br>
  <i>Otomatis. Cepat. Profesional. dan Aman</i>
</p>

---

## ✨ Fitur

- Instalasi otomatis Apache Web Server
- Setup Virtual Host berdasarkan nama domain
- Auto-Install SSL Let's Encrypt (HTTPS ready)
- Integrasi opsional Cloudflare 
- Whitelist IP Cloudflare via firewall (UFW)
- Aktifkan log IP visitor asli
- Setup UFW firewall otomatis
- Final info: direktori, file HTML utama, status Apache

---

## ⚙️ Syarat

- VPS Ubuntu/Debian
- Akses root/sudo
- Domain sudah diarahkan ke IP VPS
- Optional: Akun Cloudflare (jika pakai proxy)

---

## 🚀 Cara Pakai

- apt install bash git -y
- git clone https://github.com/radzzoffc/Apache-Setup.git
- cd apache-auto-setup
- chmod +x with-proxied-cf.sh (tanpa cf gunakan Without)
- ./with-proxied-cf.sh

---

## ⚜️ Output Script

- Masukin nama domain (tanpa https://):
- Apakah website berada di belakang Cloudflare? (ya/tidak):
- [+] Update sistem...
- [+] Install Apache dan Certbot...
- [✓] Setup selesai
- Domain       : https://mydomain.com
- Folder Web   : /var/www/mydomain.com
- Edit File    : /var/www/mydomain.com/index.html
- Status Apache: active
- Cloudflare   : ENABLED (IP protection & real IP fix aktif)

  ---

## ⚠️ Author - TqTo - Licence

- Author
  - RadzzOffc
    
- TqTo
  - RadzzOffc
  - GPT-AI

- Licence
  - Author maupun pengembang tidak bertanggung jawab atas penyalahgunaan, penanaman malicious shell, dll karena kami memberikan open source secara tidak ter-enskripsi sehingga bisa di lihat code code yg kami gunakan dalam pengembangan
