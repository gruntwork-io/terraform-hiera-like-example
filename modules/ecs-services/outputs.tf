output "service_definitions" {
  value = local.service_definitions
}

output "region_overrides" {
  value = local.region_overrides
}

output "env_overrides" {
  value = local.env_overrides
}

output "merged_service_definitions" {
  value = local.merged_service_definitions
}

output "services" {
  value = module.services
}
