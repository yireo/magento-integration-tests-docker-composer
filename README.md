# Run Magento integration tests locally
 
### Setup of Magento and your module 
Clone this repository.

Create a new file `bin/local-definitions.sh` and add your custom variables. See the `bin/definitions.sh` for possible
variables. Some example configurations are given below.

Configuration to clone a module source using Git and install it via composer:
```bash
COMPOSER_PACKAGE=yireo/magento2-googletagmanager2
MODULE_NAME=Yireo_GoogleTagManager2
GIT_REPO=git@github.com:yireo/Yireo_GoogleTagManager2.git
```

Configuration to symlink a module source and install it via composer:
```bash
COMPOSER_PACKAGE=yireo/magento2-googletagmanager2
MODULE_NAME=Yireo_GoogleTagManager2
MODULE_FOLDER=/data/git/yireo/magento2-extensions/Yireo_GoogleTagManager2/
```

Next, run `bin/setup-magento.sh`.

If successfull, run `bin/run-integration-tests.sh` (once or repeatedly).

### Tuning Integration Tests
This test procedure relies upon the Yireo Integration Testing Helper to offer a file `install-config-mysql.php`. By default, this includes a
configuration where the test framework is only run with the Magento core modules enabled and your own module enabled. However, you could tune the file
`magento-files/install-config-mysql.php` to also disable things like MSI and GraphQL .... if you want.

For repeated runs, you might also want to toggle the `TESTS_CLEANUP` constant in `magento-files/phpunit.xml`.
