resource "aws_api_gateway_rest_api" "api" {
  name        = "PascalsTriangle"
  description = "Pascal's Triangle API"
}

resource "aws_api_gateway_resource" "comments" {
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "comments"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
}

resource "aws_api_gateway_resource" "triangle" {
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "triangle"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
}

resource "aws_api_gateway_deployment" "prod" {
  depends_on = [
    "aws_api_gateway_integration.triangle_get",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "prod"
}

output "deploy_api_command" {
  value = "aws apigateway create-deployment --rest-api-id ${aws_api_gateway_rest_api.api.id} --stage-name prod"
}

output "api_gateway_url" {
  value = "${aws_api_gateway_deployment.prod.invoke_url}"
}
