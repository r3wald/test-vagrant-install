#!/bin/bash

export LC_ALL=C

sudo perl -i -pe 's#^(127.0.1.1)\s+(\w+)$#$1 $2.local $2#' /etc/hosts

wget -q -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main" | sudo tee /etc/apt/sources.list.d/elasticsearch.list
echo "deb http://packages.elasticsearch.org/logstash/1.3/debian stable main" | sudo tee /etc/apt/sources.list.d/logstash.list

echo 'mysql-server-5.5 mysql-server/root_password password vagrant' | sudo debconf-set-selections
echo 'mysql-server-5.5 mysql-server/root_password_again password vagrant' | sudo debconf-set-selections

sudo apt-get update
#sudo apt-get upgrade
sudo apt-get -y install python-software-properties build-essential \
git-core subversion curl vim \
apache2 libapache2-mod-php5 \
php5-cli php5-mysql php5-sqlite php5-curl php5-mcrypt php5-xdebug php5-dev \
mysql-server-5.5 mysql-client-5.5 libmysql-java \
openjdk-7-jre-headless elasticsearch rabbitmq-server
# logstash

curl -sS https://getcomposer.org/installer | sudo php -- --filename=composer --install-dir=/usr/local/bin

sudo a2enmod rewrite
sudo a2enmod ssl

rm -rf /var/www
ln -fs /vagrant /var/www

sudo service apache2 restart

cd /usr/share/elasticsearch
sudo bin/plugin -i mobz/elasticsearch-head
sudo bin/plugin --install jdbc --url http://xbib.org/repository/org/xbib/elasticsearch/plugin/elasticsearch-river-jdbc/1.3.0.0/elasticsearch-river-jdbc-1.3.0.0-plugin.zip
sudo cp /usr/share/java/mysql.jar plugins/jdbc

sudo service elasticsearch restart
