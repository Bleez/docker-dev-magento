# Alias

alias n98='n98-magerun2.phar'
alias magerun='n98-magerun2.phar'
alias mage='php -d memory_limit=-1 -f bin/magento'
alias magento='php -d memory_limit=-1 -f bin/magento'
alias node='nodejs'

function m2_upgrade() {
   rm -r var/
   php bin/magento setup:upgrade
}

function m2_clear() {
   rm -r var/
   echo -e "\033[36mApagando var/\033[0m"
   rm -r generated/
   echo -e "\033[36mApagando generated/\033[0m"
   rm -r pub/static/frontend/$1
   echo -e "\033[36mApagando pub/static/frontend/$1\033[0m"
   rm -r pub/static/adminhtml/$1
   echo -e "\033[36mApagando pub/static/adminhtml/$1\033[0m"
   echo -e "\033[35mLoja limpa com sucesso\033[0m"
}

function m2_deploy() {
   m2_clear "$1"
   php bin/magento setup:static-content:deploy pt_BR -f
}

function m2_reindex() {
   php bin/magento indexer:reindex
   echo -e "\033[36mIndices limpos\033[0m"
}

function m2_collect_phrases() {
   php bin/magento i18n:collect-phrases --output="app/project/$1/Tema/i18n/pt_BR.csv" app/project/$1/Tema;
}

alias disable_fucking_modules="php bin/magento module:disable --clear-static-content Magento_Inventory Magento_InventoryAdminUi Magento_InventoryApi Magento_InventoryBundleProduct Magento_InventoryBundleProductAdminUi Magento_InventoryCatalog Magento_InventorySales Magento_InventoryCatalogAdminUi Magento_InventoryCatalogApi Magento_InventoryCatalogSearch Magento_InventoryConfigurableProduct Magento_InventoryConfigurableProductAdminUi Magento_InventoryConfigurableProductIndexer Magento_InventoryConfiguration Magento_InventoryConfigurationApi Magento_InventoryGroupedProduct Magento_InventoryGroupedProductAdminUi Magento_InventoryGroupedProductIndexer Magento_InventoryImportExport Magento_InventoryIndexer Magento_InventoryLowQuantityNotification Magento_InventoryLowQuantityNotificationAdminUi Magento_InventoryLowQuantityNotificationApi Magento_InventoryMultiDimensionalIndexerApi Magento_InventoryProductAlert Magento_InventoryReservations Magento_InventoryReservationsApi Magento_InventoryCache Magento_InventorySalesAdminUi Magento_InventorySalesApi Magento_InventorySalesFrontendUi Magento_InventoryShipping Magento_InventorySourceDeductionApi Magento_InventorySourceSelection Magento_InventorySourceSelectionApi Magento_InventoryShippingAdminUi Magento_InventoryDistanceBasedSourceSelectionAdminUi Magento_InventoryDistanceBasedSourceSelectionApi Magento_InventoryElasticsearch Magento_InventoryExportStockApi Magento_InventoryReservationCli Magento_InventoryExportStock Magento_CatalogInventoryGraphQl Magento_InventorySetupFixtureGenerator -f"

# NVM

export NVM_DIR="/var/www/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
