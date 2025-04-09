# syntax=docker/dockerfile:1

# ✅ Base image with Node and minimal system footprint
FROM node:18-bullseye-slim

# ✅ Set working directory
WORKDIR /app

# ✅ Copy environment file early (optional but fine)
COPY .env.example .env

# ✅ Copy all source files
COPY . .

# ✅ Install system dependencies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        gnupg2 \
        wget \
        unzip \
        curl \
        php-cli \
        php-mbstring \
        php8.1 \
        php8.1-curl \
        php8.1-xml \
        php8.1-zip \
        php8.1-gd \
        php8.1-mbstring \
        php8.1-mysql \
        php8.1-bcmath && \
    apt-get install -y composer

# ✅ Install PHP and JS dependencies
RUN composer install && \
    npm install

# ✅ Run artisan setup commands
RUN php artisan key:generate

# ✅ Clean up to reduce image size
RUN rm -rf /var/lib/apt/lists/*

# ✅ Expose port if needed by Vite
EXPOSE 8000 5173

# ✅ Run your custom script
CMD ["bash", "./run.sh"]