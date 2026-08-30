required_providers {
  alicloud = {
    source  = "aliyun/alicloud"
    version = "= 1.288.0"
  }
}

provider "alicloud" "this" {
  config {
    region     = var.region
    access_key = var.ALICLOUD_ACCESS_KEY
    secret_key = var.ALICLOUD_SECRET_KEY
  }
}
