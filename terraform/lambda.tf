locals {
    artifact_bucket = "sell-my-stuff-backend-bucket"
}

data "aws_s3_object" "lambda_package" {
  bucket = local.artifact_bucket
  key    = "artifacts/lambda_package.zip"
}

data "aws_s3_object" "dependencies" {
    bucket = local.artifact_bucket
    key    = "artifacts/dependencies.zip"
}

# Create Lambda Function
resource "aws_lambda_function" "sell_my_stuff" {
  function_name     = "sell_my_stuff_function"
  role              = aws_iam_role.lambda_role.arn
  handler           = "sell_my_stuff.lambda_handler"
  runtime           = "python3.13"
  s3_bucket         = local.artifact_bucket
  s3_key            = data.aws_s3_object.lambda_package.key
  s3_object_version = data.aws_s3_object.lambda_package.version_id
  filename          = data.aws_s3_object.lambda_package.body
  layers            = [ aws_lambda_layer_version.dependencies.arn ]
  timeout = 300
}

resource "aws_lambda_layer_version" "dependencies" {
    layer_name        = "dependencies_layer"
    compatible_runtimes = ["python3.13"]
    s3_bucket        = local.artifact_bucket
    s3_key           = data.aws_s3_object.dependencies.key
    s3_object_version = data.aws_s3_object.dependencies.version_id
}

resource "aws_lambda_permission" "sell_my_stuff" {
    function_name = aws_lambda_function.sell_my_stuff.function_name
    action        = "lambda:InvokeFunction"
    principal     = "apigateway.amazonaws.com"
    source_arn    = "${aws_api_gateway_rest_api.sell_my_stuff.execution_arn}/*/*"
    statement_id  = "AllowAPIGatewayInvoke"
}