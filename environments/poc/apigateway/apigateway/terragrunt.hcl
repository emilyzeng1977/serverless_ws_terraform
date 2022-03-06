include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/apigateway/apigateway"
}

dependency "ws_connect" {
  config_path = "../../lambda/python_demo/ws_connect"
}

dependency "ws_disconnect" {
  config_path = "../../lambda/python_demo/ws_disconnect"
}

dependency "ws_message" {
  config_path = "../../lambda/python_demo/ws_message"
}

locals {
}

inputs = {
  apigateway_name   = "tom-websocket-gw-demo"

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
      function_name = "ws-python-connect"
    },
    "$disconnect" = {
      function_name = "ws-python-disconnect"
    },
    "onMessage" = {
      function_name = "ws-python-message"
    }
  }
}
