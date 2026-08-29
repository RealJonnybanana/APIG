output "gateway_id" {
  description = "ID of the Cloud Native API Gateway instance."
  value       = alicloud_apig_gateway.this.id
}

output "gateway_name" {
  description = "Name of the Cloud Native API Gateway instance."
  value       = alicloud_apig_gateway.this.gateway_name
}

output "gateway_status" {
  description = "Current APIG gateway status reported by Alibaba Cloud."
  value       = alicloud_apig_gateway.this.status
}

output "gateway_type" {
  description = "APIG gateway workload type."
  value       = alicloud_apig_gateway.this.gateway_type
}

output "gateway_edition" {
  description = "APIG gateway edition."
  value       = alicloud_apig_gateway.this.gateway_edition
}

output "environments" {
  description = "Environments created by the APIG service for the gateway."
  value       = alicloud_apig_gateway.this.environments
}

output "load_balancers" {
  description = "Ingress load balancers reported by the APIG service."
  value       = alicloud_apig_gateway.this.load_balancers
}

output "security_group_id" {
  description = "ID of the security group created or associated by the APIG service."
  value       = try(alicloud_apig_gateway.this.security_group[0].security_group_id, null)
}

output "zone_mappings" {
  description = "Resolved zone and vSwitch mappings reported by the APIG service."
  value       = alicloud_apig_gateway.this.zones
}
