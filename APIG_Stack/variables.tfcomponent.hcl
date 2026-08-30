variable "ALICLOUD_ACCESS_KEY" {
  description = "Access key for the new Alibaba Cloud account that owns the APIG instance."
  type        = string
  sensitive   = true
  ephemeral   = true
}

variable "ALICLOUD_SECRET_KEY" {
  description = "Secret key paired with ALICLOUD_ACCESS_KEY."
  type        = string
  sensitive   = true
  ephemeral   = true
}

variable "region" {
  description = "Alibaba Cloud region in which the APIG instance and supplied network exist."
  type        = string
}

variable "gateway_name" {
  description = "Stable name of the Cloud Native API Gateway instance."
  type        = string
}

variable "vpc" {
  description = "Existing VPC used by APIG. This Stack does not create or modify the VPC."
  type = object({
    id   = string
    name = optional(string)
  })
}

variable "zone_mappings" {
  description = "Existing availability-zone and vSwitch mappings supplied to APIG manual zone selection."
  type = list(object({
    zone_id      = string
    vswitch_id   = string
    vswitch_name = optional(string)
  }))
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
}

variable "tags" {
  description = "Tags applied to the APIG instance."
  type        = map(string)
  default     = {}
}
