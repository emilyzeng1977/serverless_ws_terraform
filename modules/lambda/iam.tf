locals {
  role_name = coalesce(var.function_name, var.function_name, "*")

}

resource "aws_iam_role" "lambda" {
  count = var.create_role ? 1 : 0
  name = "${var.function_name}-lambda"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "additional_jsons" {
  count = var.create_role && var.attach_policy_jsons ? var.number_of_policy_jsons : 0

  name   = "${local.role_name}-policy-${count.index}"
  path = "/tf-managed/"
  policy = var.policy_jsons[count.index]
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "additional_jsons" {
  count = var.create_role && var.attach_policy_jsons ? var.number_of_policy_jsons : 0

  role       = aws_iam_role.lambda[0].name
  policy_arn = aws_iam_policy.additional_jsons[count.index].arn
}




