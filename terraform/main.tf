# Creating sns identities
resource "aws_ses_email_identity" "name" {
  email = "abhishekdropbox01@gmail.com"  
}
# lamnda for saying hello

data "aws_iam_policy_document" "lambda-role-say_hello" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_s3_object" "lambda-code-say_hello" {
  bucket = "python-package-api"
  key = "api/sayingthanks/lambda_function.zip"
}

resource "aws_iam_role" "iam-role-say_hello" {
  assume_role_policy = data.aws_iam_policy_document.lambda-role-say_hello.json
  name = "iam-role-for-lambda-sayhello"
}

resource "aws_lambda_function" "lambda-fucntion-say_hello" {
  function_name = "say_hello"
  role = aws_iam_role.iam-role-say_hello.arn
  handler = "lambda_function.lambda_handler"
  s3_bucket = "python-package-api"
  s3_key = "api/sayingthanks/lambda_function.zip"
  runtime = "Python 3.9"
}

