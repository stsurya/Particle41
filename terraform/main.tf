# main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.10.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "57074f76-9363-4df2-9bbd-0311a481913e"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnet_map
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value]
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "acctest-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "env" {
  name                       = var.containerapp_env_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
}

resource "azurerm_container_app" "app" {
  name                         = var.containerapp_name
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"

  template {
    container {
      name   = "app"
      image  = var.container_image
      cpu    = 0.5
      memory = "1.0Gi"
    }
  }

  ingress {
    external_enabled           = true
    target_port                = var.container_port
    allow_insecure_connections = false
    transport                  = "auto"
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}

resource "azurerm_public_ip" "appgw_pip" {
  name                = "${var.application_gateway_name}-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.application_gateway_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = azurerm_subnet.subnets["AppGatewaySubnet"].id
  }

  frontend_ip_configuration {
    name                 = "frontendIp"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  backend_address_pool {
    name  = "backendPool"
    fqdns = [azurerm_container_app.app.ingress[0].fqdn]
  }

  backend_http_settings {
    name                                = "httpSettings"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 20
    probe_name                          = "health-probe"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    pick_host_name_from_backend_address = false
    host_name                           = azurerm_container_app.app.ingress[0].fqdn
  }

  probe {
    name                                      = "health-probe"
    protocol                                  = "Http"
    path                                      = "/"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = false
    host                                      = azurerm_container_app.app.ingress[0].fqdn
    port                                      = 80
  }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "frontendIp"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "httpListener"
    backend_address_pool_name  = "backendPool"
    backend_http_settings_name = "httpSettings"
    priority                   = 100
  }
}
