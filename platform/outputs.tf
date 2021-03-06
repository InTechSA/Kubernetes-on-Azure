output "container_registry_name" {
  value = azurerm_container_registry.poc.name
}

output "container_registry_url" {
  value = azurerm_container_registry.poc.login_server
}

output "ressource_group_name" {
  value = azurerm_resource_group.poc.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.poc.name
}