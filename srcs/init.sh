service mysql start

chown -R www-data /var/www
chmod -R 755 /var/www
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/igearheasite.pem -keyout /etc/nginx/ssl/igearheasite.key -subj "/C=RU/ST=Kazan/L=Kazan/O=42 School/OU=igearhea/CN=igearheasite"
mv ./tmp/nginx-conf /etc/nginx/sites-available/igearheasite
ln -s /etc/nginx/sites-available/igearheasite /etc/nginx/sites-enabled/igearheasite
rm -rf /etc/nginx/sites-enabled/default

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' identified by 'qwerty' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo "update mysql.user set plugin = 'mysql_native_password' where user='admin';" | mysql -u root --skip-password

mkdir /var/www/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/phpmyadmin
mv ./tmp/phpmyadmin.inc.php /var/www/phpmyadmin/config.inc.php

cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/
mv /tmp/wp-config.php /var/www/wordpress/

rm /phpMyAdmin-4.9.0.1-all-languages.tar.gz
rm /init.sh

service php7.3-fpm start
service nginx start
bash