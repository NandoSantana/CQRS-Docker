#!/bin/sh

# Aguardar o MySQL estar pronto
echo "Aguardando MySQL..."
while ! nc -z mysql 3306; do
  sleep 1
done

echo "MySQL está pronto."

# Rodar migrações sem risco de modificar dados
php artisan migrate --force

# Iniciar o PHP-FPM
exec php-fpm