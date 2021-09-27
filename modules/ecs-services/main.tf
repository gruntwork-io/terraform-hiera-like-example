locals {
  # Automatically discover services based on the YAML files in the applications folder
  service_paths = fileset(path.module, "../../applications/*.yaml")

  # Load the service definitions (the YAML files)
  service_definitions = { 
    for path in local.service_paths : 
    trimsuffix(basename(path), ".yaml") => yamldecode(file(path)) 
  }

  # Load any overrides for the current region (e.g., eu-west-1, us-west-1, etc)
  region_overrides = { 
    for service_name in keys(local.service_definitions) : 
    service_name => yamldecode(file("${path.module}/../../applications/${var.aws_region}/${service_name}.yaml")) 
    if fileexists("${path.module}/../../applications/${var.aws_region}/${service_name}.yaml")
  }

  # Load any overrides for the current env (e.g., dev, stage, prod)
  env_overrides = { 
    for service_name in keys(local.service_definitions) : 
    service_name => yamldecode(file("${path.module}/../../applications/${var.env}/${service_name}.yaml")) 
    if fileexists("${path.module}/../../applications/${var.env}/${service_name}.yaml")
  }

  # Merge all the definitions together, in the right order, so more specific overrides actually override earlier ones
  # Note: this is a shallow merge. Terraform doesn't yet support deep merge (https://github.com/hashicorp/terraform/issues/24987). 
  # If you need deep merge, you could use a module like: https://github.com/Invicton-Labs/terraform-null-deepmerge
  merged_service_definitions = {
    for service_name, definition in local.service_definitions :
    service_name => merge(definition, lookup(local.region_overrides, service_name, {}), lookup(local.env_overrides, service_name, {}))
  }
}

# For each service, use the ecs-service module to deploy it to ECS, passing the merged settings in
module "services" {
  source = "../ecs-service"

  for_each = local.merged_service_definitions

  service_name        = each.key
  aws_region          = var.aws_region
  cpu                 = lookup(each.value, "cpu")
  memory              = lookup(each.value, "memory")
  min_number_of_tasks = lookup(each.value, "min_number_of_tasks", null)
  max_number_of_tasks = lookup(each.value, "max_number_of_tasks", null)
  enable_auto_scaling = lookup(each.value, "enable_auto_scaling", null)
}
