resource "aws_iam_role" "lambda_role" {
  name               = "sell_my_stuff_lambda_role"
  assume_role_policy = file("${path.module}/files/iam/assume_role.json")
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "sell_my_stuff_lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = file("${path.module}/files/iam/lambda_policy.json")
}

resource "aws_iam_role" "github_actions_role" {
  name = "GitHubActionsRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "github_actions_policy" {
  name = "GitHubActionsPolicy"
  role = aws_iam_role.github_actions_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lambda:GetFunction",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:CreateFunction",
          "lambda:DeleteFunction",
          "lambda:InvokeFunction",
          "lambda:ListFunctions",
          "lambda:GetLayerVersion",
          "lambda:PublishLayerVersion",
          "lambda:DeleteLayerVersion",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}

data "aws_caller_identity" "current" {}



