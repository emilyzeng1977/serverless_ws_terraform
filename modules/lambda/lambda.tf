resource "aws_lambda_function" "this" {
  description      = var.description
  function_name    = var.function_name
  runtime          = var.runtime
  handler          = var.handler

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  s3_bucket         = var.bucket_name
  s3_key            = var.bucket_key
  role              = var.create_role ? aws_iam_role.lambda[0].arn : var.lambda_role

  timeout = var.timeout
  publish = var.publish

  depends_on = [resource.aws_s3_bucket_object.this]
}
