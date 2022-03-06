include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/apigateway/apigateway"
}

dependency "websocket_connect" {
  config_path = "../../lambda/python_demo/websocket_connect"
}

dependency "websocket_disconnect" {
  config_path = "../../lambda/python_demo/websocket_disconnect"
}

locals {
}

inputs = {
  apigateway_name   = "tom-websocket-gw-demo"

  # Routes and integrations
  apigateway_integrations = {
    "$connect" = {
      lambda_arn = dependency.websocket_connect.outputs.lambda_function_invoke_arn
    },
    "$disconnect" = {
      lambda_arn = dependency.websocket_disconnect.outputs.lambda_function_invoke_arn
    },
    "onMessage" = {
      lambda_arn = dependency.websocket_disconnect.outputs.lambda_function_invoke_arn
    }
  }

  # Lambda permission
  lambda_permissions = {
    "$connect" = {
      function_name = "python-demo-websocket-connect"
//    },
//    "$disconnect" = {
//      function_name = "python-demo-websocket-disconnect"
    }
  }

//  lambda_permission_function_name = "python-demo-websocket-connect"
//
//  lambda_permission_source_arn = "arn:aws:execute-api:ap-southeast-2:204532658794:n66q5d65pl/*/$connect"
}
