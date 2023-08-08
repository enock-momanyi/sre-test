#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras enable php8.0
yum install -y php-cli php-pdo php-fpm php-mysqlnd

sed -i "s#user.*=.*apache#user = nginx#" /etc/php-fpm.d/www.conf
sed -i "s#listen.acl_user.*#listen.acl_users = nginx#" /etc/php-fpm.d/www.conf
sed -i "s#group.*=.*apache#group = nginx#" /etc/php-fpm.d/www.conf
sed -i "s#listen.*www.sock#listen = /var/run/php-fpm/www.sock#" /etc/php-fpm.d/www.conf
sed -i "s#.*listen.owner.*#listen.owner = nginx#" /etc/php-fpm.d/www.conf
sed -i "s#.*listen.group.*#listen.group = nginx#" /etc/php-fpm.d/www.conf
sed -i "s#.*listen.mode.*#listen.mode = 0664#" /etc/php-fpm.d/www.conf
#sed -i "s#.*listen.acl_groups.*#listen.acl_groups = nginx#" /etc/php-fpm.d/www.conf
sed -i "s#listen.allowed_clients = 127.0.0.1#listen.allowed_clients = #" /etc/php-fpm.d/www.conf


systemctl start php-fpm

sudo amazon-linux-extras install -y nginx1

sed -i "s#root.*#root        /var/www/html;#" /etc/nginx/nginx.conf

systemctl restart php-fpm
systemctl restart nginx
