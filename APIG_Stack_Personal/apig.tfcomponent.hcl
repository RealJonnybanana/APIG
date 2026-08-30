component "apig" {
  # Match the git component-source form used by the formal Stack code.
  source = "git::https://github.com/RealJonnybanana/the_AIA_modules.git//terraform-alicloud-apig?ref=main"

  inputs = {
    gateway_name        = var.gateway_name
    gateway_type        = var.gateway_type
    gateway_edition     = var.gateway_edition
    payment_type        = var.payment_type
    spec                = var.spec
    vpc_id              = var.vpc.id
    zone_selection      = "Manual"
    vswitch_id          = null
    network_access_type = var.network_access_type
    resource_group_id   = var.resource_group_id
    tags                = var.tags

    zones = [
      for mapping in var.zone_mappings : {
        zone_id    = mapping.zone_id
        vswitch_id = mapping.vswitch_id
      }
    ]
  }

  providers = {
    alicloud = provider.alicloud.this
  }
}
