include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/apigateway/apigateway_stage"
}

dependency "apigateway" {
  config_path = "../apigateway"
}

locals {
}

inputs = {
  api_id = dependency.apigateway.outputs.apigatewayv2_api_id
  stage_name        = "poc"
  stage_variables   = {
    test1 = "abc123"
  }
}
