#!/bin/bash

echo "Masukin nama domain (tanpa https://):"
read domain

echo "[+] Update sistem..."
sudo apt update && sudo apt upgrade -y

echo "[+] Install Apache dan Certbot..."
sudo apt install apache2 certbot python3-certbot-apache -y

echo "[+] Create direktori /var/www/$domain ..."
sudo mkdir -p /var/www/$domain
sudo chown -R $USER:$USER /var/www/$domain
sudo chmod -R 755 /var/www/$domain

cat <<EOF | sudo tee /var/www/$domain/index.html
<html>
  <head>
    <title>Welcome to $domain!</title>
  </head>
  <body>
    <h1>Apache berhasil disetup untuk $domain</h1>
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

echo "[+] Setup SSL untuk $domain ..."
sudo certbot --apache -d $domain -d www.$domain --non-interactive --agree-tos -m admin@$domain

sudo systemctl enable apache2
STATUS=$(systemctl is-active apache2)

echo ""
echo "====================================================="
echo "[✓] Setup selesai"
echo "Domain       : https://$domain"
echo "Folder Web   : /var/www/$domain"
echo "Edit File    : /var/www/$domain/index.html"
echo "Status Apache: $STATUS"
echo "====================================================="
