locals {
  env_vars            = read_terragrunt_config(find_in_parent_folders())
  lambda_prefix_name    = local.env_vars.locals.lambda_prefix_name
  lambda_s3_bucket    = "tom.niu26"
  lambda_s3_key       = "ws.zip"
}
