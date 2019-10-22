provider "azurerm" {
  version = "1.35.0"
}

provider "azuread" {
  version = "0.6.0"
}

data "azurerm_subscription" "primary" {}

resource "azuread_application" "poc" {
  name = var.poc-name
}

resource "azuread_application_password" "poc" {
  value                 = var.client_secret
  end_date_relative     = "${2 * 365 * 24}h"
  application_object_id = azuread_application.poc.id
}

resource "azuread_service_principal" "poc" {
  application_id = azuread_application.poc.application_id
}

resource "azurerm_role_assignment" "poc" {
  principal_id         = azuread_service_principal.poc.object_id
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
}

resource "azurerm_resource_group" "poc" {
  location = var.location
  name     = var.poc-name
}

resource "azurerm_virtual_network" "poc" {
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  name                = var.poc-name
  resource_group_name = azurerm_resource_group.poc.name

  subnet {
    address_prefix = "10.0.0.0/24"
    name           = var.poc-name
  }

  tags = {
    environment = "poc"
    maintener   = var.author
  }
}

resource "azurerm_log_analytics_workspace" "poc" {
  location            = var.location
  name                = var.poc-name
  resource_group_name = azurerm_resource_group.poc.name
  sku                 = "PerGB2018"
  retention_in_days   = "30"
}

resource "azurerm_kubernetes_cluster" "poc" {
  dns_prefix          = var.poc-name
  location            = var.location
  name                = var.poc-name
  resource_group_name = azurerm_resource_group.poc.name
  kubernetes_version  = var.kubernetes_version

  addon_profile {
    http_application_routing {
      enabled = true
    }
    kube_dashboard {
      enabled = true
    }
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.poc.id
    }
  }

  agent_pool_profile {
    name    = "pocprofile"
    vm_size = var.vm_size
    count   = var.vm_count
  }

  service_principal {
    client_id     = azuread_application.poc.application_id
    client_secret = azuread_application_password.poc.value
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = var.ssh_pub_key != "" ? var.ssh_pub_key : file("~/.ssh/id_rsa.pub")
    }
  }

  tags = {
    environment = "poc"
    maintener   = var.author
  }
}