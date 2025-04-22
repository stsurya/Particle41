resource_group_name = "rg-demo-containerapp"
location            = "West Europe"
vnet_name           = "vnet-demo"
vnet_address_space  = "10.0.0.0/16"

subnet_map = {
  "AppGatewaySubnet" = "10.0.0.0/24"
  "Subnet1"          = "10.0.1.0/24"
  "Subnet2"          = "10.0.2.0/24"
}

containerapp_env_name = "containerapp-env-demo"
containerapp_name     = "demo-container-app"
container_image       = "stsurya/minimal:v1"
container_port        = 5000

application_gateway_name = "appgw-demo"
