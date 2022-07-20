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

# Use this data source to lookup information about the current AWS partition in which Terraform is working.
# This will return the identifier of the current partition (e.g., aws in AWS Commercial, aws-us-gov in AWS GovCloud,
# aws-cn in AWS China).
# https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html
data "aws_partition" "current" {}
