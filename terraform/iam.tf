resource "aws_iam_role" "lambda_role" {
  name               = "sell_my_stuff_lambda_role"
  assume_role_policy = file("${path.module}/files/iam/assume_role.json")
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "sell_my_stuff_lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = file("${path.module}/files/iam/lambda_policy.json")
  
}

