#!/bin/bash

echo "Install openssh for remote connection";
sudo apt-get update;
sudo apt-get install openssh-server -y;

echo "Install git";
sudo apt-get install git-core -y;

echo "Adding dotdeb.org repo";
# install curl and add dotdeb key
sudo apt-get install curl -y;
curl https://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -;
# add dotdeb repos
sudo echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list;
sudo echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list;
sudo apt-get update

echo "install php7.0";
sudo apt-get install php7.0 php7.0-cli php7.0-bcmath php7.0-curl php7.0-gd php7.0-intl php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-xml php7.0-soap php7.0-xsl php7.0-zip php7.0-json php7.0-xdebug -y


