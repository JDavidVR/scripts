#!/bin/bash

echo 'Curl Vim';
sudo apt-get install curl -y;
sudo apt install vim -y;

echo 'MySQL 5.7';
sudo apt install lsb-release apt-transport-https ca-certificates -y;
wget -O mysql-apt-config.deb https://dev.mysql.com/get/mysql-apt-config_0.8.7-1_all.deb;
sudo dpkg -i mysql-apt-config.deb;
sudo apt update;
sudo apt install mysql-server -y;

echo 'PHP 7.1';
sudo apt install apt-transport-https ca-certificates -y;
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg;
sudo su -c 'echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list';
sudo apt update;
sudo apt install php7.1-apcu php7.1-bcmath php7.1-cli php7.1-curl php7.1-fpm php7.1-gd php7.1-intl php7.1-mcrypt php7.1-mysql php7.1-soap php7.1-xml php7.1-zip php7.1-imagick -y;

echo 'Elasticsearch 5.5+';
sudo apt install apt-transport-https -y;
wget -O - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -;
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list;
sudo apt update;
sudo apt install openjdk-8-jre-headless -y;
sudo apt install elasticsearch -y;

echo 'Apache';
sudo apt install apache2 -y;
sudo apt install libapache2-mod-fastcgi -y;
sudo a2enmod rewrite proxy_fcgi;
sudo a2enconf php7.1-fpm;
sudo systemctl restart apache2;

echo 'Install phpmyadmin';
sudo apt-get install phpmyadmin -y;
sudo cp ./phpmyadmin.conf /etc/apache2/sites-available/;
sudo a2ensite phpmyadmin.conf;
sudo systemctl reload apache2;

echo 'User Group'
id;

echo -e " \
\n sudo vim /etc/php/7.1/fpm/pool.d/www.conf \
\n # replace these environment variables: \
\n user = my_user \
\n group = my_group \
\n listen = /run/php/php7.1-fpm.sock \
\n listen.user = www-data \
\n listen.group = www-data \
";

echo "Node";
curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -;
sudo apt-get install -y nodejs;

echo "Yarn";
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -;
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list;
sudo apt-get update && sudo apt-get install yarn;
