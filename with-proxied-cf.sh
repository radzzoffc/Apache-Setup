#!/bin/bash

echo "Masukin nama domain (tanpa https://):"
read domain

echo "Apakah website berada di belakang Cloudflare? (ya/tidak):"
read is_cf

echo "[+] Update sistem..."
sudo apt update && sudo apt upgrade -y

echo "[+] Install Apache dan Certbot..."
sudo apt install apache2 certbot python3-certbot-apache curl ufw -y

echo "[+] Create direktori /var/www/$domain ..."
sudo mkdir -p /var/www/$domain
sudo chown -R $USER:$USER /var/www/$domain
sudo chmod -R 755 /var/www/$domain

cat <<EOF | sudo tee /var/www/$domain/index.html
<html>
  <head>
    <title>Radzz | Aphace successfully installed</title>
  </head>
  <body>
  <br><br>
    <h1>Apache berhasil disetup sempurna untuk<br>$domain</h1>
  </body>
</html>
EOF

echo "[+] Konfigurasi virtual host..."
sudo bash -c "cat > /etc/apache2/sites-available/$domain.conf" <<EOL
<VirtualHost *:80>
    ServerName $domain
    ServerAlias www.$domain
    DocumentRoot /var/www/$domain

    <Directory /var/www/$domain>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    DirectoryIndex index.php index.html

    ErrorLog \${APACHE_LOG_DIR}/$domain-error.log
    CustomLog \${APACHE_LOG_DIR}/$domain-access.log combined
</VirtualHost>
EOL

sudo a2ensite $domain.conf
sudo a2dissite 000-default.conf
sudo systemctl reload apache2

echo "[+] Setup SSL dengan Let's Encrypt untuk $domain ..."
sudo certbot --apache -d $domain -d www.$domain --non-interactive --agree-tos -m admin@$domain

if [[ "$is_cf" == "ya" ]]; then
    echo "[+] Detected behind Cloudflare - Setup IP filter & real IP support..."
    curl https://www.cloudflare.com/ips-v4 -o cf-ips.txt
    for ip in $(cat cf-ips.txt); do
        sudo ufw allow from $ip to any port 80,443 proto tcp
    done
    sudo ufw default deny incoming
    sudo ufw allow ssh
    sudo ufw --force enable

    sudo a2enmod remoteip
    sudo bash -c 'cat > /etc/apache2/conf-available/remoteip.conf' <<EOF
RemoteIPHeader CF-Connecting-IP
RemoteIPTrustedProxy 173.245.48.0/20
RemoteIPTrustedProxy 103.21.244.0/22
RemoteIPTrustedProxy 103.22.200.0/22
RemoteIPTrustedProxy 103.31.4.0/22
RemoteIPTrustedProxy 141.101.64.0/18
RemoteIPTrustedProxy 108.162.192.0/18
RemoteIPTrustedProxy 190.93.240.0/20
RemoteIPTrustedProxy 188.114.96.0/20
RemoteIPTrustedProxy 197.234.240.0/22
RemoteIPTrustedProxy 198.41.128.0/17
RemoteIPTrustedProxy 162.158.0.0/15
RemoteIPTrustedProxy 104.16.0.0/13
RemoteIPTrustedProxy 104.24.0.0/14
RemoteIPTrustedProxy 172.64.0.0/13
RemoteIPTrustedProxy 131.0.72.0/22
EOF

    sudo a2enconf remoteip
    sudo systemctl restart apache2
fi

sudo systemctl enable apache2
STATUS=$(systemctl is-active apache2)

echo ""
echo "====================================================="
echo "[✓] Setup selesai"
echo "Domain       : https://$domain"
echo "Folder Web   : /var/www/$domain"
echo "Edit File    : /var/www/$domain/index.html"
echo "Status Apache: $STATUS"
[[ "$is_cf" == "ya" ]] && echo "Cloudflare   : ENABLED (IP protection & real IP fix aktif)"
echo "====================================================="
