# Deploying ECS services dynamically from Hiera-like YAML definitions with Terraform/Terragrunt

**THIS IS PURELY EXAMPLE CODE. IT IS NOT THOROUGHLY TESTED, WILL NOT BE SUPPORTED, AND IS NOT MEANT FOR PRODUCTION USE.**

This repo shows an example of how to use Terraform/Terragrunt to deploy services to ECS based on definitions in `yaml` files that loosely resemble the approach used with Hiera.

The basic idea is:

1. You define the services you want to deploy in `.yaml` files in the `applications` folder.
1. You define overrides for the services for specific regions or environments in subfolders of the `applications` folder.
1. The `ecs-services` module reads all these in, merges all the settings together, and uses Terraform to deploy each one using the `ecs-service` module.
1. The `ecs-service` module here is just a mock module used for testing, but it's hopefully clear that it could be replaced with a real module.
1. This allows you to manage all your services in a DRY, Hiera-like manner, deploying all the services to any given environment with just a single `terragrunt.hcl` file that never really has to change (so it's mostly a marker file so your deployments are captured as code).

See the [`ecs-services` module](modules/ecs-services) for where most of the logic lives; see the `terragrunt.hcl` files in the `environments` folder for an example usage.

