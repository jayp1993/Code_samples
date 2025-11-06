resource "azurerm_mssql_database" "mssql_database" {
  name         = var.mssqldatabase_name
  server_id    = var.mssql_server_id
  collation    = var.collation
  license_type = var.license_type
  max_size_gb  = var.max_size_gb
  sku_name     = var.sku_name

}