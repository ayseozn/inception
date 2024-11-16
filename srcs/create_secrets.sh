#!/bin/bash

echo "aysozen.42.fr" | docker secret create DOMAIN_NAME -
echo "Inception" | docker secret create TITLE -
echo "/etc/ssl/certs/inception.crt" | docker secret create CERTIFICATES_OUT -
echo "/etc/ssl/private/inception.key" | docker secret create CERTIFICATES_KEYOUT -
echo "wordpress" | docker secret create MYSQL_DATABASE_NAME -
echo "aysozen" | docker secret create MYSQL_USER -
echo "123" | docker secret create MYSQL_PASSWORD -
echo "aysozen@42.fr" | docker secret create MYSQL_EMAIL -
echo "aysozen" | docker secret create WORDPRESS_ADMIN_NAME -
echo "aysozen123" | docker secret create WORDPRESS_ADMIN_PASSWORD -
echo "aysozen@42.fr" | docker secret create WORDPRESS_ADMIN_EMAIL -
