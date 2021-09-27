variable "aws_region" {
  type        = string
  description = "The AWS region to deploy to"
}

variable "service_name" {
  description = "The name of the ECS service to deploy"
  type        = string
}

variable "cpu" {
  description = "The number of CPU units to allocate for the service"
  type        = number
}

variable "memory" {
  description = "The amount of memory, in MB, to allocate for the service"
  type        = number
}

variable "min_number_of_tasks" {
  description = "Minimum number of tasks to run"
  type        = number
  default     = 1
}

variable "max_number_of_tasks" {
  description = "Maximum number of tasks to run"
  type        = number
  default     = 3
}

variable "enable_auto_scaling" {
  description = "Set to true to enable auto scaling"
  type        = bool
  default     = true
}
