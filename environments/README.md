# Environments

This defines examples of live environments for this service. Each one is meant to be deployed with Terragrunt. The folder structure is roughly:

- `<account_name>-<region>`: An AWS account and AWS region combination, such as `back-office-eu-west-1`.
  - `<env>`: An environment in that account, such as `dev` or `prod`.
  	- `<resources>`: Resources to deploy with Terragrunt. E.g., The `applications/terragrunt.hcl` deploys all the services defined in `applications/*.yaml`: see the [`ecs-service module`](../modules/ecs-services) for details. The `terragrunt.hcl` files are built to automatically parse the AWS region (`<region>`) and environment name (`<env>`) from the folder structure. So to deploy all your services in a new environment, you have to copy just this single `terragrunt.hcl` into the new environment and run `apply`. 