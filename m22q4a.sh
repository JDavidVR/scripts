#!/bin/bash

echo 'Remove Q4OS UX';
sudo service tdm stop; sudo apt remove tdm-trinity --allow-remove-essential -y;

echo 'Install Curl Vim Git';
sudo apt install curl vim git-core -y;

echo 'MySQL 5.7';
sudo apt install lsb-release apt-transport-https ca-certificates -y;
wget -O mysql-apt-config.deb https://dev.mysql.com/get/mysql-apt-config_0.8.7-1_all.deb;
sudo dpkg -i mysql-apt-config.deb;
sudo apt update;
sudo apt install mysql-server -y;
# sudo apt install lsb-release apt-transport-https ca-certificates -y; wget -O mysql-apt-config.deb https://dev.mysql.com/get/mysql-apt-config_0.8.7-1_all.deb; sudo dpkg -i mysql-apt-config.deb; sudo apt update; sudo apt install mysql-server -y; sudo apt install mysql-server -y;

echo 'PHP 7.1';
sudo apt install apt-transport-https ca-certificates -y;
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg;
sudo su -c 'echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list';
sudo apt update;
sudo apt install php7.1-fpm php7.1-cli php7.1-bcmath php7.1-curl php7.1-gd php7.1-intl php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-xml php7.1-soap php7.1-xsl php7.1-zip php7.1-json php7.1-xdebug -y;
sudo phpenmod xdebug;
# sudo apt install apt-transport-https ca-certificates -y; sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg; sudo su -c 'echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list'; sudo apt update;
# sudo apt install php7.1-fpm php7.1-cli php7.1-bcmath php7.1-curl php7.1-gd php7.1-intl php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-xml php7.1-soap php7.1-xsl php7.1-zip php7.1-json php7.1-xdebug -y; sudo phpenmod xdebug;

echo 'Apache';
sudo apt install apache2 -y;
sudo apt install libapache2-mod-fcgid -y;
sudo a2enmod rewrite proxy_fcgi;
sudo a2enconf php7.1-fpm;
sudo systemctl restart apache2;
# sudo apt install apache2 -y; sudo apt install libapache2-mod-fcgid -y; sudo a2enmod rewrite proxy_fcgi; sudo a2enconf php7.1-fpm; sudo systemctl restart apache2;

echo 'Install phpmyadmin';
cd /usr/share/;
sudo wget https://files.phpmyadmin.net/phpMyAdmin/4.7.7/phpMyAdmin-4.7.7-all-languages.zip;
sudo unzip phpMyAdmin-4.7.7-all-languages.zip; sudo rm phpMyAdmin-4.7.7-all-languages.zip;
sudo mv phpMyAdmin-4.7.7-all-languages phpmyadmin;
mysql -uroot -p < /usr/share/phpmyadmin/sql/create_tables.sql;
sudo cp ./phpmyadmin.conf /etc/apache2/sites-available/; sudo a2ensite phpmyadmin.conf;
# Solve $cfg['blowfish_secret'] issue generate IN:
# http://www.passwordtool.hu/blowfish-password-hash-generator
# COPY generated blowfish in:
# sudo vim /usr/share/phpmyadmin/libraries/config.default.php;

#### Deprecated:latest q4os is using php7.2 dependecies to install phpmyadmin
#sudo apt-get install phpmyadmin -y;
#sudo cp ./phpmyadmin.conf /etc/apache2/sites-available/;
#sudo a2ensite phpmyadmin.conf;
#sudo systemctl reload apache2;
# sudo apt-get install phpmyadmin -y; sudo cp ./phpmyadmin.conf /etc/apache2/sites-available/; sudo a2ensite phpmyadmin.conf; sudo systemctl reload apache2;

echo 'User Group'
id;

echo -e " \
\n sudo vim /etc/php/7.1/fpm/pool.d/www.conf \
\n # replace these environment variables: \
\n user = my_user \
\n group = my_group \
\n listen = /run/php/php7.1-fpm.sock \
\n listen.owner = www-data \
\n listen.group = www-data \
\n  \
\n sudo vim /etc/apache2/envvars \
\n export APACHE_RUN_USER=www-data \
\n export APACHE_RUN_GROUP=www-data \
";
