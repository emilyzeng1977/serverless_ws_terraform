# Archive file
data "archive_file" "lambda_zip" {
  type             = "zip"
  source_file      = var.source_file
  output_path       = var.output_path
}

# Upload an object
resource "aws_s3_bucket_object" "this" {
  bucket = var.bucket_name
  key    = var.bucket_key
  acl    = "private"  # or can be "public-read"
  source = var.output_path
  etag = filemd5(var.output_path)

  depends_on = [data.archive_file.lambda_zip]
}
