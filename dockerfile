# Get Ampache source and dependencies
FROM composer AS builder
RUN apk add git
RUN git clone https://github.com/ampache/ampache -b develop .
RUN composer install --prefer-source --no-interaction
RUN rm -rf .git

# Build lightweight image
FROM php:7.4-apache-buster

# Additinal packages
RUN apt update && apt install -y \
    libjpeg62-turbo-dev \
    libpng-dev

# Additional extensions
RUN docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install pdo_mysql gd

RUN mkdir -m 777 /var/log/ampache

COPY --from=builder --chown=www-data:www-data "/app" "/var/www/html"