#!/bin/bash
script=`readlink -f $BASH_SOURCE`
scriptFolder=`dirname $script`
source $scriptFolder/definitions.sh

export PHP_VERSION=$PHP_VERSION

docker-compose down
rm -rf src/
rm -rf module-src/
