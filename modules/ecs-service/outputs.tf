output "ecs_service_id" {
  value = random_id.mock_ecs_service.id
}

output "ecs_service_arn" {
  value = "arn:aws:ecs:${var.aws_region}:123456789012:service/${var.service_name}"
}
