# This file would define all the resources to deploy an ECS service: e.g., ECS Task Definition, IAM Role, Security Groups, etc.
# To keep testing simple, this example just uses random resources to make it look like this is a real module.
resource "random_id" "mock_ecs_service" {
  keepers = {
    service_name        = var.service_name
    cpu                 = var.cpu
    memory              = var.memory
    min_number_of_tasks = var.min_number_of_tasks
    max_number_of_tasks = var.max_number_of_tasks
    enable_auto_scaling = var.enable_auto_scaling
  }

  byte_length = 8
}
