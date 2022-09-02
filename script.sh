#!/bin/bash
apt-get update
apt install nginx -y
apt install lsb-release ca-certificates apt-transport-https software-properties-common -y
add-apt-repository ppa:ondrej/php -y
apt install php8.1-fpm php-mysql php8.1-curl php8.1-xml -y
apt-get install git
cd /var/www
git clone https://github.com/laravel/laravel.git
chown -R www-data:www-data /var/www/laravel
cd laravel
apt-get install composer -y
runuser -u www-data -- composer install --optimize-autoloader --no-dev
runuser -u www-data -- cp .env.example .env
runuser -u www-data -- php artisan key:generate
runuser -u www-data -- php artisan config:cache
runuser -u www-data -- php artisan route:cache
runuser -u www-data -- php artisan view:cache
sed -i '41s/.*/root \/var\/www\/laravel\/public;/' /etc/nginx/sites-available/default
sed -i '44s/.*/index index.html index.htm index.nginx-debian.html index.php;/' /etc/nginx/sites-available/default
sed -i '64s/.*/location ~ \\.php$ { include snippets\/fastcgi-php.conf; fastcgi_pass unix:\/var\/run\/php\/php8.1-fpm.sock; }/' /etc/nginx/sites-available/default
nginx -t
systemctl reload nginx