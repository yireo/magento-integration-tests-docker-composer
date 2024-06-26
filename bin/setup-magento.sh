#!/bin/bash
script=`readlink -f $BASH_SOURCE`
scriptFolder=`dirname $script`
source $scriptFolder/definitions.sh

echo "Removing src/ folder"
test -d src/ && rm -rf src/
mkdir -p src/

export PHP_VERSION=$PHP_VERSION
echo "Setting PHP_VERSION $PHP_VERSION"

if [ ! -d module-src ] ; then
    if [ -n "$GIT_REPO" ]; then
        echo "Cloning GIT_REPO: $GIT_REPO"
        git clone $GIT_REPO module-src || exit
    fi 

    if [ -n "$MODULE_FOLDER" ]; then
        echo "Symlinking MODULE_FOLDER: $MODULE_FOLDER"
        ln -s $MODULE_FOLDER module-src || exit
    fi 
fi
    
echo "docker-compose down && docker-compose up -d"
docker-compose down
docker-compose up -d

if [ ! -d src/app/etc ]; then
docker-compose exec -T --user www-data -w /var/www/html php-fpm bash <<EOF
composer create-project --no-install --stability dev --prefer-source --repository-url=$MAGENTO_REPO $MAGENTO_PACKAGE:$MAGENTO_VERSION . || exit

if [ ! -f composer.json ] ; then
    echo "We don't have a composer file"; exit
fi

mkdir -p var/composer_home
test -f ~/.composer/auth.json && cp ~/.composer/auth.json var/composer_home/auth.json

composer config minimum-stability dev
composer config prefer-stable true

composer config repositories.0 --unset
composer config repositories.magento-mirror composer $MAGENTO_REPO
composer config repositories.magento-marketplace composer https://repo.magento.com/

composer require --no-install yireo/magento2-integration-test-helper:@dev

if [ ! -f composer.json ] ; then
    echo "We don't have a composer file"; exit
fi

if [ ! -d /var/www/magento2-module-source ] ; then
    echo "Folder 'magento2-module-source' does not exist"; exit
fi

composer config repositories.magento2-module-source path /var/www/magento2-module-source || exit

composer require --no-install $COMPOSER_PACKAGE:$COMPOSER_VERSION

composer install || exit

if [ ! -d "vendor" ] ; then
    echo "Composer directory does not exist. Something went wrong here"; exit
fi

if [ ! -f app/etc/env.php ] ; then
php -d memory_limit=-1 bin/magento setup:install --base-url=http://localhost/ \
--db-host=${DB_HOST} --db-name=${DB_NAME} \
--db-user=${DB_USER} --db-password=${DB_PASSWORD} \
--admin-firstname=$ADMIN_FIRSTNAME --admin-lastname=$ADMIN_LASTNAME \
--admin-email=$ADMIN_EMAIL \
--admin-user=$ADMIN_USER --admin-password=$ADMIN_PASSWORD \
--backend-frontname=$ADMIN_PATH --language=en_US \
--currency=USD --timezone=Europe/Amsterdam --cleanup-database \
--sales-order-increment-prefix="ORD$" --session-save=db \
--${ES_HOST_OPTION}=${ES_HOST} --${ES_PORT_OPTION}=${ES_PORT} \
--search-engine=${SEARCH_ENGINE} \
--use-rewrites=1 || exit;
fi

EOF
fi

docker-compose exec -T --user www-data -w /var/www/html php-fpm bash <<EOF
composer require $COMPOSER_PACKAGE:$COMPOSER_VERSION
bin/magento module:enable ${MODULE_NAME}
bin/magento module:status ${MODULE_NAME}
bin/magento deploy:mode:set developer
bin/magento setup:di:compile || exit
bin/magento deploy:mode:set developer

EOF
