<?php

use Yireo\IntegrationTestHelper\Utilities\DisableModules;
use Yireo\IntegrationTestHelper\Utilities\InstallConfig;

$disableModules = (new DisableModules(__DIR__.'/../../../../'))
    ->disableAll()
    ->enableMagento()
    ->disableMagentoInventory()
    ->disableGraphQl()
    ->enableByMagentoModuleEnv();

return (new InstallConfig())
    ->setDisableModules($disableModules)
    ->addDb('mysql')
    ->addRedis('redis')
    ->addElasticSearch('opensearch', 'elasticsearch', 9200)
    ->get();


