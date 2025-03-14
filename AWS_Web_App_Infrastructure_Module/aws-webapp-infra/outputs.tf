output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.networking.vpc_id
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.compute.alb_dns_name
}

output "rds_endpoint" {
  description = "The endpoint of the RDS database"
  value       = module.database.rds_endpoint
}
