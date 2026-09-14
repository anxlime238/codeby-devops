#!/bin/bash
set -e

apt update
apt install apache2 -y
apt install openssl -y

mkdir -p /var/www/anna-lesson8

cat > /var/www/anna-lesson8/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to lesson8!</title>
</head>
<body>
    <h1>Well done! Lesson8 is over....</h1>
    <p>...almost</p>
</body>
</html>
EOF

openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/private/lesson8.key -x509 -days 365 -out /etc/ssl/certs/lesson8.crt -subj "/CN=anna-lesson8.local" -addext "subjectAltName=DNS:anna-lesson8.local,DNS:www.anna-lesson8.local" 

chmod 600 /etc/ssl/private/lesson8.key

cp /etc/ssl/certs/lesson8.crt /vagrant/lesson8.crt

a2enmod ssl

a2dissite 000-default.conf || true
a2dissite default-ssl.conf || true

cat > /etc/apache2/sites-available/anna-lesson8.conf <<EOF
<VirtualHost *:80>
    ServerName anna-lesson8.local
    ServerAlias www.anna-lesson8.local

    Redirect permanent / https://anna-lesson8.local/
</VirtualHost>


<VirtualHost *:443>
    ServerName anna-lesson8.local

    DocumentRoot /var/www/anna-lesson8

    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/lesson8.crt
    SSLCertificateKeyFile /etc/ssl/private/lesson8.key

    <Directory /var/www/anna-lesson8>
        Require all granted
    </Directory>
</VirtualHost>


<VirtualHost *:443>
    ServerName www.anna-lesson8.local

    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/lesson8.crt
    SSLCertificateKeyFile /etc/ssl/private/lesson8.key

    Redirect permanent / https://anna-lesson8.local/
</VirtualHost>
EOF

a2ensite anna-lesson8.conf
apache2ctl configtest

systemctl enable apache2
systemctl restart apache2
