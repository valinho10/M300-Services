#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2 libxml2-dev
cat <<EOF | sudo tee -a /var/www/html/index.html
Webseite von Server 1
EOF
sudo service apache2 restart
sudo ufw allow 80/tcp
echo "y" | sudo ufw enable  