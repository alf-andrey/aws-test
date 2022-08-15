
output "private_subnets_us" {
  description = "List of IDs of private subnets"
  value       = module.vpc_us.private_subnets
}

output "private_subnets_eu" {
  description = "List of IDs of private subnets"
  value       = module.vpc_eu.private_subnets
}