#!/bin/bash

echo 'MySQL 5.7';
sudo apt install mysql-server -y;

echo 'PHP 7.1';
sudo add-apt-repository ppa:ondrej/php; 
sudo apt update;
sudo apt install php7.1-fpm php7.1-cli php7.1-bcmath php7.1-curl php7.1-gd php7.1-intl php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-xml php7.1-soap php7.1-xsl php7.1-zip php7.1-json php7.1-xdebug -y;
sudo phpenmod xdebug;

echo 'Apache';
sudo apt install apache2 -y;
sudo apt install libapache2-mod-fcgid -y;
sudo a2enmod rewrite proxy_fcgi;
sudo a2enconf php7.1-fpm;
sudo service apache2 restart;
#sudo systemctl restart apache2;

echo 'Install phpmyadmin';
sudo apt install phpmyadmin -y;
sudo cp ./phpmyadmin.conf /etc/apache2/sites-available/; sudo a2ensite phpmyadmin.conf;
sudo service apache2 reload;

echo 'Instal composer';
sudo wget https://getcomposer.org/download/1.6.2/composer.phar -O /usr/local/bin/composer;
sudo chmod +x /usr/local/bin/composer;

# sudo service php7.1-fpm stop
# sudo vi /etc/php/7.1/fpm/pool.d/www.conf
# replace these environment variables:
# user = my_user
# group = my_group
# listen = /run/php/php7.1-fpm.sock
# listen.user = www-data
# listen.group = www-data
# modify apache user
# sudo vin /etc/apache/envvars
