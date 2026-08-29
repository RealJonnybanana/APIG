output "apig_gateway_id" {
  description = "ID of the APIG instance created in the new Alibaba Cloud account."
  type        = string
  value       = component.apig.gateway_id
}

output "apig_gateway_name" {
  description = "Name of the APIG instance."
  type        = string
  value       = component.apig.gateway_name
}

output "apig_gateway_status" {
  description = "Current APIG control-plane status reported by Alibaba Cloud."
  type        = string
  value       = component.apig.gateway_status
}

output "apig_zone_mappings" {
  description = "Zone and vSwitch mappings reported by the APIG service after creation."
  type        = any
  value       = component.apig.zone_mappings
}

output "apig_load_balancers" {
  description = "Load balancers reported by the APIG service."
  type        = any
  value       = component.apig.load_balancers
}

output "apig_security_group_id" {
  description = "Security group ID created or associated by the APIG service."
  type        = string
  value       = component.apig.security_group_id
}
