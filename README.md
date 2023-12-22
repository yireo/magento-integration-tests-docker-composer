# Run Magento integration tests locally

### Setup
Clone this repository.

Create a new file `bin/local-definitions.sh` like the following:
```bash
COMPOSER_PACKAGE=yireo/magento2-googletagmanager2
MODULE_NAME=Yireo_GoogleTagManager2
GIT_REPO=git@github.com:yireo/Yireo_GoogleTagManager2.git
```

Next, run `bin/setup-magento.sh`.

If successfull, run `bin/run-integration-tests.sh`.