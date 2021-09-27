# ECS services

This is a module that can be used to dynamically load the info for services to deploy into ECS by loading `*.yaml` files from the `applications` folder. This very loosely mimics the approach used with Hiera. 

Here's how it works:

1. We read all the `*.yaml` files from the `applications` folder. The name of the file is used as the name of the service: e.g., if you have an `admin-web.yaml`, this module assumes you want a service called `admin-web`.
1. Each `yaml` file defines a basic set of configs for that service:
    * `cpu`
    * `memory`
    * `min_number_of_tasks`
    * `max_number_of_tasks`
    * `enable_auto_scaling`
1. The values can be overridden for specific regions or environments by creating a folder with that region or environment name and putting a `.yaml` file in it. Examples: 
    * If you create `applications/us-west-1/admin-web.yaml`, then when you deploy the service in the `us-west-1` region, any settings in that file will override the settings in the base `applications/admin-web.yaml file`.
    * If you create `applications/prod/admin-web.yaml`, then when you deploy the service in the `prod` environment, any settings in that file will override the settings in the base `applications/admin-web.yaml file`.
    * Take a look at the code to see how you could extend it to add support for additional override rules as desired.    
1. This module loops over all the service definitions and overrides and deploys each one as an ECS service using the [`ecs-service` module](../ecs-service).
    * Any configs not defined in a `yaml` file or override file will use the defaults defined in this module.