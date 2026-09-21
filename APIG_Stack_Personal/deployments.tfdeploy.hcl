# Create this sensitive environment-category variable set in HCP Terraform and
# replace the name below before the first deployment. Its values must belong to
# the new Alibaba Cloud account that will own the APIG instance.
store "varset" "access_keys" {
  name     = "aia-ali-nonprod-operations-credentials"
  category = "env"
}

deployment "apig" {
  inputs = {
    ALICLOUD_ACCESS_KEY = store.varset.access_keys.ALICLOUD_ACCESS_KEY
    ALICLOUD_SECRET_KEY = store.varset.access_keys.ALICLOUD_SECRET_KEY

    region       = "cn-hongkong"
    gateway_name = "apig-hk01-cn-hk-n-test"

    gateway_type        = "API"
    gateway_edition     = "Professional"
    payment_type        = "PayAsYouGo"
    spec                = "apigw.small.x1"
    network_access_type = "Intranet"
    resource_group_id   = null

    vpc = {
      id   = "vpc-j6csfszzn6j4ypwxdoogw"
      name = "Workload VPC"
    }

    zone_mappings = [
      {
        zone_id      = "cn-hongkong-c"
        vswitch_id   = "vsw-j6c2sez0xn0vrb3nxyzjl"
        vswitch_name = "alb_2"
      },
      {
        zone_id      = "cn-hongkong-d"
        vswitch_id   = "vsw-j6chgvmem3p6x5lsn6m74"
        vswitch_name = "test2"
      },
    ]

    lifecycle {
    # 忽略阿里云 API 自动回填 vswitch 导致的假删除和强制重建
    ignore_changes = [
      vswitch
    ]

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


    tags = {
      ManagedBy = "terraform-stack"
    }
  }
}
