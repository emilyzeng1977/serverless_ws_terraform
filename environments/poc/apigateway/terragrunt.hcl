include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/apigateway"
}

dependency "websocketui" {
  config_path = "../lambda/python_demo/websocketui"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders())
}

inputs = {
  apigateway_name   = "tomniu-websocket-gw-demo"

  # Routes and integrations
  apigateway_integrations = {
    "$connect" = {
      lambda_arn = dependency.websocketui.outputs.lambda_function_invoke_arn
    },
    "$disconnect" = {
      lambda_arn = dependency.websocketui.outputs.lambda_function_invoke_arn
    },
    "onMessage" = {
      lambda_arn = dependency.websocketui.outputs.lambda_function_invoke_arn
    }
  }

  # Lambda permission
  lambda_permissions = {
    "routeKey" = {
      function_name = "${local.env_vars.locals.lambda_prefix_name}-websocketui"
    }
  }

  # API Gateway Stages
  apigateway_stages = {
    "poc" = {
      has_default_varibles = true
      stage_variables   = {}
    },
    "dev" = {
      has_default_varibles = false
      stage_variables   = {}
    }
  }
}
