# # Use the official PHP 8.2 FPM base image
# FROM php:8.2-fpm

# # Set the working directory
# WORKDIR /var/www/html

# # Install system dependencies and PHP extensions
# RUN apt-get update && \
#     apt-get install -y libpng-dev libjpeg-dev zip unzip && \
#     docker-php-ext-configure gd --with-jpeg && \
#     docker-php-ext-install gd pdo pdo_mysql

# # Install Composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# # Copy composer files and install dependencies
# COPY composer.json composer.lock ./
# RUN composer install --no-dev --no-scripts --no-progress

# # Copy application files
# COPY . .

# # Set permissions
# RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# # Expose port 9000
# EXPOSE 9000

# # Command to start PHP-FPM
# CMD ["php-fpm"]


# Use the official PHP 8.2 FPM base image
FROM php:8.2-fpm


# Install system dependencies and PHP extensions
RUN apt-get update && \
    apt-get install -y libpng-dev libjpeg-dev zip unzip && \
    docker-php-ext-configure gd --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY . /app

# Copy composer files and install dependencies
COPY composer.json composer.lock ./
RUN composer install

EXPOSE 8000

CMD php artisan serve --host=0.0.0.0 --port=8000
