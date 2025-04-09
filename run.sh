#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run Laravel queue in background
php artisan queue:work &

# Run migrations and seeders
php artisan migrate --force
php artisan db:seed --force

# Build frontend assets
npm run build

# Clear and optimize caches
php artisan optimize:clear
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Start the Laravel development server
php artisan serve --host=0.0.0.0 --port=8000