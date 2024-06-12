# Run Magento integration tests locally

### Setup
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
