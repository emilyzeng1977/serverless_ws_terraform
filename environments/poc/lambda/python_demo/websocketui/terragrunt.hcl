include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/lambda"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders())
}

inputs = {
  function_name = "${local.env_vars.locals.lambda_prefix_name}-websocketui"
  description   = "Python lambda webSocket demo"
  handler       = "websocketui.lambda_handler"
  runtime       = "python3.8"

  create_role   = true

  create_package      = false
  s3_existing_package = {
    bucket = "${local.env_vars.locals.lambda_s3_bucket}"
    key    = "${local.env_vars.locals.lambda_s3_key}"
  }

  source_file = "../../environments/poc/lambda/python_demo/src/websocketui.py"
  output_path = "websocketui.zip"
  bucket_name = "tom.niu26"
  bucket_key = "websocketui.zip"

  policy_jsons        = [<<EOF
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
,
<<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:PutLogEvents",
                "logs:CreateLogStream",
                "logs:CreateLogGroup"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-southeast-2:204532658794:log-group:/aws/lambda/emily-ws-python-message:*:*",
                "arn:aws:logs:ap-southeast-2:204532658794:log-group:/aws/lambda/emily-ws-python-message:*"
            ],
            "Sid": ""
        }
    ]
}
EOF
]
  number_of_policy_jsons = 2

  tags = {
    "Managed By" = "Terragrunt"
  }
}
