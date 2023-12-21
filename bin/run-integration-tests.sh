#!/bin/bash
script=`readlink -f $BASH_SOURCE`
scriptFolder=`dirname $script`
source $scriptFolder/definitions.sh

cp magento-files/phpunit.xml src/dev/tests/integration/
cp magento-files/install-config-mysql.php src/dev/tests/integration/etc/
cp magento-files/fake-config.php src/app/etc/config.php

docker-compose exec -T --user www-data -w /var/www/html php-fpm bash <<EOF
composer require $COMPOSER_PACKAGE:$COMPOSER_VERSION

cd dev/tests/integration
MAGENTO_MODULE=$MODULE_NAME php -d memory_limit=-1 ../../../vendor/bin/phpunit ../../../vendor/$COMPOSER_PACKAGE/Test/Integration/
EOF

