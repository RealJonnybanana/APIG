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
    gateway_name = "apig-hk01-cn-hk-n-ssvc01"

    gateway_type        = "API"
    gateway_edition     = "Professional"
    payment_type        = "PayAsYouGo"
    spec                = "apigw.small.x1"
    network_access_type = "Intranet"
    resource_group_id   = null

    vpc = {
      id   = "vpc-j6c0b3jkywidjs3z011nw"
      name = "vpc-hk01-cn-hk-n-ssvc01"
    }

    zone_mappings = [
      {
        zone_id      = "cn-hongkong-b"
        vswitch_id   = "vsw-j6cwn9jcrsxwfb94ibk7j"
        vswitch_name = "vsw-n-ssvc01-default-b-10.82.73.0-24"
      },
      {
        zone_id      = "cn-hongkong-c"
        vswitch_id   = "vsw-j6ckiur8xqnis1v2hqop6"
        vswitch_name = "vsw-n-ssvc01-default-c-10.82.74.0-24"
      },
      {
        zone_id      = "cn-hongkong-d"
        vswitch_id   = "vsw-j6cgieag7xdu9o3bqnjvw"
        vswitch_name = "vsw-n-ssvc01-default-d-10.82.75.0-24"
      },
    ]

    tags = {
      ManagedBy = "terraform-stack"
    }
  }
}
