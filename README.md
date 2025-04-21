<h1 align="center" style="font-size:40px;">🔥 Apache Auto Setup + Cloudflare Integration</h1>

<p align="center">
  <b>Script bash all-in-one buat install Apache, domain setup, SSL, dan dukungan penuh Cloudflare.</b><br>
  <i>Otomatis. Cepat. Profesional.</i>
</p>

---

## ✨ Fitur

- Instalasi otomatis Apache Web Server
- Setup Virtual Host berdasarkan nama domain
- Auto-Install SSL Let's Encrypt (HTTPS ready)
- Integrasi opsional Cloudflare (tanya dulu via terminal)
  - Whitelist IP Cloudflare via firewall (UFW)
  - Aktifkan log IP visitor asli (fix mod_remoteip)
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

bash
git clone https://github.com/yourusername/apache-auto-setup.git
cd apache-auto-setup
chmod +x auto-apache.sh
./auto-apache.sh

---

## ⚜️ Output Script
Masukin nama domain (tanpa https://):
mydomain.com
Apakah website lo berada di belakang Cloudflare? (ya/tidak):
ya
[+] Update sistem...
[+] Install Apache dan Certbot...
[✓] Setup selesai!
Domain       : https://mydomain.com
Folder Web   : /var/www/mydomain.com
Edit File    : /var/www/mydomain.com/index.html
Status Apache: active
Cloudflare   : ENABLED (IP protection & real IP fix aktif)
