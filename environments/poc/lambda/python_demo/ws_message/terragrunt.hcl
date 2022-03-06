include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr:///terraform-aws-modules/lambda/aws//?version=2.34.1"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders())
}

inputs = {
  function_name = "${local.env_vars.locals.lambda_prefix_name}-message"
  description   = "lambda example of websocket connect"
  handler       = "ws-message.lambda_handler"
  runtime       = "python3.8"

  create_role   = true

  create_package      = false
  s3_existing_package = {
    bucket = "${local.env_vars.locals.lambda_s3_bucket}"
    key    = "${local.env_vars.locals.lambda_s3_key}"
  }

  attach_policy_json = true
  policy_json        = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "execute-api:Invoke",
                "execute-api:ManageConnections"
            ],
            "Resource": "arn:aws:execute-api:*:*:*"
        }
    ]
}
EOF

  tags = {
    "Managed By" = "Terragrunt"
  }
}
