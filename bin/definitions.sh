#!/bin/bash
MAGENTO_PACKAGE=magento/project-community-edition
MAGENTO_VERSION=2.4.6-p3
PHP_VERSION=8.2
MAGENTO_REPO=https://mirror.mage-os.org/
COMPOSER_PACKAGE=
COMPOSER_VERSION=@dev
GIT_REPO=
MODULE_NAME=

DB_HOST=mysql
DB_PORT=3306
DB_HOST_PORT=${DB_HOST}:${DB_PORT}
DB_USER=root
DB_PASSWORD=root
DB_NAME=magento2

SEARCH_ENGINE=opensearch
ES_HOST=opensearch
ES_HOST_OPTION=opensearch-host
ES_PORT=9200
ES_PORT_OPTION=opensearch-port

ADMIN_FIRSTNAME=John
ADMIN_LASTNAME=Doe
ADMIN_EMAIL=johndoe@example.com
ADMIN_USER=johndoe@example.com
ADMIN_PASSWORD=P@ssword1234
ADMIN_PATH=admin

script=`readlink -f $BASH_SOURCE`
scriptFolder=`dirname $script`
test -f $scriptFolder/local-definitions.sh && source $scriptFolder/local-definitions.sh
