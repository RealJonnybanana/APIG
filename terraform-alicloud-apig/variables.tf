variable "gateway_name" {
  description = "Stable name of the Cloud Native API Gateway instance."
  type        = string

  validation {
    condition     = trimspace(var.gateway_name) != ""
    error_message = "gateway_name must not be empty."
  }
}

variable "gateway_type" {
  description = "Gateway workload type: API for API Gateway or AI for AI Gateway."
  type        = string
  default     = "API"

  validation {
    condition     = contains(["API", "AI"], var.gateway_type)
    error_message = "gateway_type must be API or AI."
  }
}

variable "gateway_edition" {
  description = "Gateway edition supported by the Alicloud APIG API."
  type        = string
  default     = "Professional"

  validation {
    condition     = contains(["Professional", "Serverless", "MultiTenantServerless"], var.gateway_edition)
    error_message = "gateway_edition must be Professional, Serverless, or MultiTenantServerless."
  }
}

variable "payment_type" {
  description = "Billing mode. Subscription instances cannot be destroyed by the Alicloud Provider."
  type        = string
  default     = "PayAsYouGo"

  validation {
    condition     = contains(["PayAsYouGo", "Subscription"], var.payment_type)
    error_message = "payment_type must be PayAsYouGo or Subscription."
  }
}

variable "spec" {
  description = "Gateway specification. apigw.small.x1 is the specification documented by Alicloud Provider 1.288.0."
  type        = string
  default     = "apigw.small.x1"

  validation {
    condition     = trimspace(var.spec) != ""
    error_message = "spec must not be empty."
  }
}

variable "vpc_id" {
  description = "ID of the service VPC associated with the gateway."
  type        = string

  validation {
    condition     = trimspace(var.vpc_id) != ""
    error_message = "vpc_id must not be empty."
  }
}

variable "zone_selection" {
  description = "Availability-zone selection mode. Auto uses vswitch_id; Manual uses zones."
  type        = string
  default     = "Auto"

  validation {
    condition     = contains(["Auto", "Manual"], var.zone_selection)
    error_message = "zone_selection must be Auto or Manual."
  }
}

variable "vswitch_id" {
  description = "vSwitch ID used when zone_selection is Auto. Set it to null when using Manual selection."
  type        = string
  default     = null
  nullable    = true
}

variable "zones" {
  description = "Explicit zone and vSwitch mappings used when zone_selection is Manual."
  type = list(object({
    zone_id    = string
    vswitch_id = string
  }))
  default = []

  validation {
    condition = alltrue([
      for zone in var.zones :
      trimspace(zone.zone_id) != "" && trimspace(zone.vswitch_id) != ""
    ])
    error_message = "Every zones item must contain non-empty zone_id and vswitch_id values."
  }
}

variable "network_access_type" {
  description = "Gateway ingress network exposure."
  type        = string
  default     = "Intranet"

  validation {
    condition     = contains(["Internet", "Intranet", "InternetAndIntranet"], var.network_access_type)
    error_message = "network_access_type must be Internet, Intranet, or InternetAndIntranet."
  }
}

variable "sls_logging_enabled" {
  description = "Optional instance-level SLS switch. Null omits log_config and preserves the APIG service default."
  type        = bool
  default     = null
  nullable    = true
}

variable "resource_group_id" {
  description = "Optional Alibaba Cloud resource group ID."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.resource_group_id == null ? true : trimspace(var.resource_group_id) != ""
    error_message = "resource_group_id must be null or a non-empty string."
  }
}

variable "tags" {
  description = "Tags applied to the APIG gateway."
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "Create, update, and delete timeouts for the gateway lifecycle."
  type = object({
    create = optional(string, "11m")
    update = optional(string, "5m")
    delete = optional(string, "5m")
  })
  default = {}
}
