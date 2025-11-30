# Use PHP 8.2 with required extensions
FROM php:8.2-fpm

# --- 1. System dependencies ---
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev libjpeg-dev \
    libfreetype6-dev libssl-dev libicu-dev g++ \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip intl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# --- 2. Composer ---
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# --- 3. Working directory ---
WORKDIR /var/www/html

# --- 4. Copy project files ---
COPY . .

# --- 5. Increase Composer memory ---
ENV COMPOSER_MEMORY_LIMIT=-1

# --- 6. Install PHP dependencies ---
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# --- 7. Set permissions (important for Laravel) ---
RUN chown -R www-data:www-data storage bootstrap/cache

# --- 8. Expose port 8000 for Laravel dev server ---
EXPOSE 8000

# --- 9. Auto-start Laravel on container boot ---
CMD ["php-fpm"]

RUN docker-php-ext-install opcache
