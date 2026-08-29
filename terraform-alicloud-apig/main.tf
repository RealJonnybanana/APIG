resource "alicloud_apig_gateway" "this" {
  gateway_name      = var.gateway_name
  gateway_type      = var.gateway_type
  gateway_edition   = var.gateway_edition
  payment_type      = var.payment_type
  spec              = var.spec
  resource_group_id = var.resource_group_id
  tags              = var.tags

  vpc {
    vpc_id = var.vpc_id
  }

  zone_config {
    select_option = var.zone_selection
  }

  dynamic "vswitch" {
    for_each = var.zone_selection == "Auto" ? [var.vswitch_id] : []
    content {
      vswitch_id = vswitch.value
    }
  }

  dynamic "zones" {
    for_each = var.zone_selection == "Manual" ? var.zones : []
    content {
      zone_id    = zones.value.zone_id
      vswitch_id = zones.value.vswitch_id
    }
  }

  network_access_config {
    type = var.network_access_type
  }

  dynamic "log_config" {
    for_each = var.sls_logging_enabled == null ? [] : [var.sls_logging_enabled]
    content {
      sls {
        enable = log_config.value
      }
    }
  }

  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

  lifecycle {
    precondition {
      condition = var.zone_selection == "Auto" ? (
        try(trimspace(var.vswitch_id) != "", false) && length(var.zones) == 0
        ) : (
        var.vswitch_id == null && length(var.zones) > 0
      )
      error_message = "Auto zone selection requires vswitch_id and no zones; Manual zone selection requires one or more zones and a null vswitch_id."
    }
  }
}
