#!/bin/bash
set -e

# --- Generate .env if not present ---
if [ ! -f /var/www/html/.env ]; then
    echo "Creating .env from .env.example..."
    cp /var/www/html/.env.example /var/www/html/.env
fi

# --- Generate APP_KEY if not set ---
if [ -z "$APP_KEY" ]; then
    echo "Generating APP_KEY..."
    php artisan key:generate --force
else
    # Use the APP_KEY from environment
    sed -i "s|^APP_KEY=.*|APP_KEY=${APP_KEY}|" /var/www/html/.env
fi

# --- Override .env with Render environment variables ---
# APP settings
[ -n "$APP_NAME" ] && sed -i "s|^APP_NAME=.*|APP_NAME=${APP_NAME}|" /var/www/html/.env
[ -n "$APP_URL" ] && sed -i "s|^APP_URL=.*|APP_URL=${APP_URL}|" /var/www/html/.env
[ -n "$APP_ENV" ] && sed -i "s|^APP_ENV=.*|APP_ENV=${APP_ENV}|" /var/www/html/.env
[ -n "$APP_DEBUG" ] && sed -i "s|^APP_DEBUG=.*|APP_DEBUG=${APP_DEBUG}|" /var/www/html/.env

# Database settings
[ -n "$DB_CONNECTION" ] && sed -i "s|^DB_CONNECTION=.*|DB_CONNECTION=${DB_CONNECTION}|" /var/www/html/.env
[ -n "$DB_HOST" ] && sed -i "s|^DB_HOST=.*|DB_HOST=${DB_HOST}|" /var/www/html/.env
[ -n "$DB_PORT" ] && sed -i "s|^DB_PORT=.*|DB_PORT=${DB_PORT}|" /var/www/html/.env
[ -n "$DB_DATABASE" ] && sed -i "s|^DB_DATABASE=.*|DB_DATABASE=${DB_DATABASE}|" /var/www/html/.env
[ -n "$DB_USERNAME" ] && sed -i "s|^DB_USERNAME=.*|DB_USERNAME=${DB_USERNAME}|" /var/www/html/.env
[ -n "$DB_PASSWORD" ] && sed -i "s|^DB_PASSWORD=.*|DB_PASSWORD=${DB_PASSWORD}|" /var/www/html/.env

# Google OAuth
[ -n "$GOOGLE_CLIENT_ID" ] && sed -i "s|^GOOGLE_CLIENT_ID=.*|GOOGLE_CLIENT_ID=${GOOGLE_CLIENT_ID}|" /var/www/html/.env
[ -n "$GOOGLE_CLIENT_SECRET" ] && sed -i "s|^GOOGLE_CLIENT_SECRET=.*|GOOGLE_CLIENT_SECRET=${GOOGLE_CLIENT_SECRET}|" /var/www/html/.env
[ -n "$GOOGLE_REDIRECT_URI" ] && sed -i "s|^GOOGLE_REDIRECT_URI=.*|GOOGLE_REDIRECT_URI=${GOOGLE_REDIRECT_URI}|" /var/www/html/.env

# --- Configure Apache to listen on Render's PORT ---
PORT=${PORT:-80}
echo "Configuring Apache to listen on port $PORT..."
sed -i "s/Listen 80/Listen ${PORT}/" /etc/apache2/ports.conf
sed -i "s/:80>/:${PORT}>/" /etc/apache2/sites-available/*.conf

# --- Run Laravel setup commands ---
echo "Caching Laravel configuration..."
php artisan config:cache || true
php artisan route:cache || true
php artisan view:cache || true

# --- Ensure storage directories exist ---
php artisan storage:link 2>/dev/null || true

echo "Starting Apache on port $PORT..."
exec apache2-foreground
