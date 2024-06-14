#!/bin/bash
script=`readlink -f $BASH_SOURCE`
scriptFolder=`dirname $script`
source $scriptFolder/definitions.sh

cp magento-files/phpunit.xml src/dev/tests/integration/
cp magento-files/install-config-mysql.php src/dev/tests/integration/etc/

docker-compose exec -T --user www-data -w /var/www/html php-fpm bash <<EOF
cd dev/tests/integration
test -d ../../../vendor/$COMPOSER_PACKAGE/Test/Integration/ || exit
MAGENTO_MODULE=$MODULE_NAME php -d memory_limit=-1 ../../../vendor/bin/phpunit --color ../../../vendor/$COMPOSER_PACKAGE/Test/Integration/
EOF

