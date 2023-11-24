################################
###
### OP HPE TESTING
###
################################

# Transit Modules



module "framework" {
  source  = "terraform-aviatrix-modules/backbone/aviatrix"
  version = "v1.2.2"

  global_settings = {
    transit_accounts = {
      azure = "Azure_Paul_New",
      gcp   = "GCP_Paul",
      aws   = "AWS_Paul",
    }
  }

  transit_firenet = yamldecode(file("transit.yml"))
  peering_mode = "custom"
  peering_map = {
    peering1 : {
      gw1_name                                      = module.framework.transit["transit1"].transit_gateway.gw_name,
      gw2_name                                      = module.framework.transit["transit2"].transit_gateway.gw_name,
      enable_insane_mode_encryption_over_internet   = true,
      tunnel_count                                  = 8,
    }
  }
}