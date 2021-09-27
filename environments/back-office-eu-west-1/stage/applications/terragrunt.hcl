terraform {
  source = "../../../..//modules/ecs-services"
}

locals {
  # Automatically parse AWS region and env name from file path
  parsed_path = regex(".*/environments/.*?-(?P<aws_region>..-.+?-\\d)/(?P<env>.+?)/.*", abspath(get_original_terragrunt_dir()))  
}

inputs = {
  aws_region = local.parsed_path.aws_region
  env        = local.parsed_path.env
}