include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/apigateway"
}

dependency "ws_connect" {
  config_path = "../lambda/python_demo/ws_connect"
}

dependency "ws_disconnect" {
  config_path = "../lambda/python_demo/ws_disconnect"
}

dependency "ws_message" {
  config_path = "../lambda/python_demo/ws_message"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders())
}

inputs = {
  apigateway_name   = "tomniu-websocket-gw-demo"

  # Routes and integrations
  apigateway_integrations = {
    "$connect" = {
      lambda_arn = dependency.ws_connect.outputs.lambda_function_invoke_arn
    },
    "$disconnect" = {
      lambda_arn = dependency.ws_disconnect.outputs.lambda_function_invoke_arn
    },
    "onMessage" = {
      lambda_arn = dependency.ws_message.outputs.lambda_function_invoke_arn
    }
  }

  # Lambda permission
  lambda_permissions = {
    "$connect" = {
      function_name = "${local.env_vars.locals.lambda_prefix_name}-connect"
    },
    "$disconnect" = {
      function_name = "${local.env_vars.locals.lambda_prefix_name}-disconnect"
    },
    "onMessage" = {
      function_name = "${local.env_vars.locals.lambda_prefix_name}-message"
    }
  }

  # API Gateway Stage
  stage_name        = "poc"
  stage_variables   = {
    test1 = "abc123"
  }
}
