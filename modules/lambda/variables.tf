# Lambda
variable "function_name" {
  description = "Lambda Function name"
}

variable "description" {
  description = "Lambda Function name"
}

variable "handler" {
  description = "Lambda handler"
}

variable "runtime" {
  description = "Lambda runtime"
  default = "python3.8"
}

variable "create_role" {
  description = "If create role for Lambda"
  default = true
}

variable "lambda_role" {
  description = "Lambda role"
  default = null
}

variable "create_package" {
  description = "If create package for Lambda"
  default = false
}

variable "s3_existing_package" {
  description = "S3 bucket/key for Lambda"
  type = map(string)
}

variable "attach_policy_json" {
  description = ""
  default = false
}

variable "policy_json" {
  description = ""
  default = ""
}

variable "tags" {
  description = ""
  type = map(string)
  default = {}
}

variable "timeout" {
  default = 30
}

variable "publish" {
  default = true
}

# Util
variable "source_file" {
  description = "source file"
}

variable "output_path" {
  description = "output path"
}

variable "bucket_name" {
  description = "output path"
}

variable "bucket_key" {
  description = "output path"
}

# IAM
variable "attach_policy_jsons" {
  description = "If attach policy jsons"
  default = true
}

variable "number_of_policy_jsons" {
  description = "number_of_policy_jsons"
  default = 0
}

variable "policy_jsons" {
  description = "List of additional policy documents as JSON to attach to Lambda Function role"
  type        = list(string)
  default     = []
}

