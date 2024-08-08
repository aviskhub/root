# Creating sns identities
resource "aws_ses_email_identity" "name" {
  email = "abhishekdropbox01@gmail.com"  
}
# lamnda for saying hello

data "aws_iam_policy_document" "lambda-role-say_hello-trust-policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda-role-permission" {
    statement {
    effect = "Allow"
    actions = ["logs:*"]
    sid = "lambdatocloudwatch"
    resources = ["*"] 
  }
     statement {
    effect = "Allow"
    actions = ["logs:*"]
    sid = "Allowall"
    resources = ["*"] 
  }
}

 
data "aws_s3_object" "lambda-code-say_hello" {
  bucket = "python-package-api"
  key = "api/sayingthanks/lambda_function.zip"
} 
data "aws_s3_object" "lambda-layer" {
  bucket = "python-package-api"
  key = "api/layer/lambda_layer.zip"
}

resource "aws_iam_role" "iam-role-say_hello" {
  assume_role_policy = data.aws_iam_policy_document.lambda-role-say_hello-trust-policy.json
  name = "iam-role-for-lambda-sayhello"
}

resource "aws_iam_policy" "lambda-role-policy" {
 name = "lambda-permission"
 path = "/"
 description = "policy document for allowing action for lambda"
 policy = data.aws_iam_policy_document.lambda-role-permission.json
}

resource "aws_iam_role_policy_attachment" "attachment" {
  role = aws_iam_role.iam-role-say_hello.name
  policy_arn = aws_iam_policy.lambda-role-policy.arn
}

resource "aws_lambda_function" "lambda-fucntion-say_hello" {
  function_name = "say_hello"
  role = aws_iam_role.iam-role-say_hello.arn
  handler = "lambda_function.lambda_handler"
  s3_bucket = "python-package-api"
  s3_key = data.aws_s3_object.lambda-code-say_hello.key
  s3_object_version = data.aws_s3_object.lambda-code-say_hello.version_id
  runtime = "python3.9" 
}
# creating lamda layer : keeping this layer common for all the lambda which would be created

resource "aws_lambda_layer_version" "lambda-layer" {
  layer_name = "lambda-layer"
  compatible_architectures = ["x86_64"]
  description = "Lambda layer for all the lambda dependency"
  compatible_runtimes = ["python3.9"]
  s3_bucket = "python-package-api"
  s3_key = "api/layer/lambda_layer.zip"
  s3_object_version = data.aws_s3_object.lambda-layer.version_id
} 
 
 



