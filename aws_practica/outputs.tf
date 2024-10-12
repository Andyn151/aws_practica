output "ecs_cluster_id" {
  description = "El ID del cluster ECS"
  value       = module.ecs.ecs_cluster_id
}


output "website_endpoint" {
  description = "AWS S3 Static Website Endpoint"
  value       = module.s3.website_endpoint
}

