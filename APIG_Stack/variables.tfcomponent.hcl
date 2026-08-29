variable "ALICLOUD_ACCESS_KEY" {
  description = "Access key for the new Alibaba Cloud account that owns the APIG instance."
  type        = string
  sensitive   = true
}

variable "ALICLOUD_SECRET_KEY" {
  description = "Secret key paired with ALICLOUD_ACCESS_KEY."
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Alibaba Cloud region in which the APIG instance and supplied network exist."
  type        = string

  validation {
    condition     = trimspace(var.region) != ""
    error_message = "region must not be empty."
  }
}

variable "gateway_name" {
  description = "Stable name of the Cloud Native API Gateway instance."
  type        = string

  validation {
    condition     = trimspace(var.gateway_name) != ""
    error_message = "gateway_name must not be empty."
  }
}

variable "vpc" {
  description = "Existing VPC used by APIG. This Stack does not create or modify the VPC."
  type = object({
    id   = string
    name = optional(string)
  })

  validation {
    condition     = trimspace(var.vpc.id) != ""
    error_message = "vpc.id must not be empty."
  }
}

variable "zone_mappings" {
  description = "Existing availability-zone and vSwitch mappings supplied to APIG manual zone selection."
  type = list(object({
    zone_id     = string
    vswitch_id  = string
    vswitch_name = optional(string)
  }))

  validation {
    condition = length(var.zone_mappings) > 0 && alltrue([
      for mapping in var.zone_mappings :
      trimspace(mapping.zone_id) != "" && trimspace(mapping.vswitch_id) != ""
    ])
    error_message = "zone_mappings must contain at least one mapping with non-empty zone_id and vswitch_id values."
  }

  validation {
    condition     = length(distinct([for mapping in var.zone_mappings : mapping.zone_id])) == length(var.zone_mappings)
    error_message = "zone_mappings must not contain duplicate zone IDs."
  }

  validation {
    condition     = length(distinct([for mapping in var.zone_mappings : mapping.vswitch_id])) == length(var.zone_mappings)
    error_message = "zone_mappings must not contain duplicate vSwitch IDs."
  }
}

variable "gateway_type" {
  description = "APIG workload type."
  type        = string
  default     = "API"
}

variable "gateway_edition" {
  description = "APIG gateway edition."
  type        = string
  default     = "Professional"
}

variable "payment_type" {
  description = "APIG billing mode."
  type        = string
  default     = "PayAsYouGo"
}

variable "spec" {
  description = "APIG instance specification."
  type        = string
  default     = "apigw.small.x1"
}

variable "network_access_type" {
  description = "APIG ingress network exposure."
  type        = string
  default     = "Intranet"
}

variable "resource_group_id" {
  description = "Optional existing resource group ID in the new Alibaba Cloud account."
  type        = string
  default     = null
  nullable    = true
}

variable "tags" {
  description = "Tags applied to the APIG instance."
  type        = map(string)
  default     = {}
}
