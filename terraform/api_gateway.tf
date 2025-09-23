
# Create API Gateway
resource "aws_api_gateway_rest_api" "sell_my_stuff" {
  name        = "sell-my-stuff"
  description = "API Gateway with API Key"
  body = templatefile("${path.module}/files/api/oas.yml", {
    lambda_arn = aws_lambda_function.sell_my_stuff.arn
    region     = var.region
  })    
}

# Create API Gateway Stage
resource "aws_api_gateway_stage" "sell_my_stuff" {
  deployment_id = aws_api_gateway_deployment.sell_my_stuff.id
  rest_api_id   = aws_api_gateway_rest_api.sell_my_stuff.id
  stage_name    = "prod"

  lifecycle {
    create_before_destroy = true
  }
}

# Create API Gateway Deployment
resource "aws_api_gateway_deployment" "sell_my_stuff" {
  rest_api_id = aws_api_gateway_rest_api.sell_my_stuff.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.sell_my_stuff.body))
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Create Usage Plan
resource "aws_api_gateway_usage_plan" "sell_my_stuff" {
  name        = "sell-my-stuff-usage-plan"
  description = "Usage plan for API Gateway"
  api_stages {
    api_id = aws_api_gateway_rest_api.sell_my_stuff.id
    stage  = aws_api_gateway_stage.sell_my_stuff.stage_name
  }

  quota_settings {
    limit  = 1000
    period = "MONTH"
  }

}



# Create API Key
resource "aws_api_gateway_api_key" "sell_my_stuff" {
  name        = "sell-my-stuff-api-key"
  description = "API Key for accessing the sell-my-stuff API"
}

# Associate API Key with Usage Plan
resource "aws_api_gateway_usage_plan_key" "sell_my_stuff" {
  key_id        = aws_api_gateway_api_key.sell_my_stuff.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.sell_my_stuff.id
}

