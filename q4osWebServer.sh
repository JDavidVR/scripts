#!/bin/bash

echo 'Install openssh-server';
sudo apt-get install openssh-server -y;

echo 'Install git-core';
sudo apt-get install git-core -y;
git --version;

echo 'Adding repo dotdeb.gpg'
sudo apt-get install curl -y;
curl https://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -

echo 'Installing PHP 7.0.x and APACHE 2.X';
sudo su -c "echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list"; 
sudo su -c "echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list";
sudo apt-get update;

sudo apt-get install php7.0 php7.0-cli php7.0-bcmath php7.0-curl php7.0-gd php7.0-intl php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-xml php7.0-soap php7.0-xsl php7.0-zip php7.0-json php7.0-xdebug -y;
sudo phpenmod xdebug;
sudo a2enmod rewrite;

echo 'Install mysql 5.7.x';
wget https://repo.mysql.com/mysql-apt-config_0.8.4-1_all.deb;
sudo dpkg -i mysql-apt-config_0.8.4-1_all.deb;
sudo apt-get update;
sudo apt-get install mysql-community-server;

echo 'Install phpmyadmin';
sudo apt-get install phpmyadmin;
sudo cp ./phpmyadmin.conf /etc/apache2/sites-available/;
sudo a2ensite phpmyadmin.conf;
sudo service apache2 restart;
