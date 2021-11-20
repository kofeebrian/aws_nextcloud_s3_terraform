#!/bin/bash

# Install dependencies
sudo apt update -y
sudo apt install -y apache2 mariadb-server libapache2-mod-php7.4
sudo apt install -y php7.4-gd php7.4-mysql php7.4-curl php7.4-mbstring php7.4-intl
sudo apt install -y php7.4-gmp php7.4-bcmath php-imagick php7.4-xml php7.4-zip

touch 1.txt

echo $(whoami) >> whoami.txt
echo $(pwd) >> pwd.txt

# Download and unpack Nextcloud
sudo curl https://download.nextcloud.com/server/releases/latest.tar.bz2 -o latest.tar.bz2
sudo tar -xjf latest.tar.bz2 

touch 2.txt