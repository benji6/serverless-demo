resource "aws_api_gateway_integration" "comments_get" {
  http_method             = "${aws_api_gateway_method.comments_get.http_method}"
  integration_http_method = "POST"
  resource_id             = "${aws_api_gateway_resource.comments.id}"
  rest_api_id             = "${aws_api_gateway_rest_api.api.id}"
  type                    = "AWS"
  uri                     = "${aws_lambda_function.comments_get.invoke_arn}"
}

resource "aws_api_gateway_integration_response" "comments_get_200" {
  depends_on = [
    "aws_api_gateway_integration.comments_get",
    "aws_api_gateway_method_response.comments_get_200",
  ]

  http_method = "${aws_api_gateway_method.comments_get.http_method}"
  resource_id = "${aws_api_gateway_resource.comments.id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  status_code = "${aws_api_gateway_method_response.comments_get_200.status_code}"
}

resource "aws_api_gateway_integration_response" "comments_get_500" {
  depends_on = [
    "aws_api_gateway_integration.comments_get",
    "aws_api_gateway_method_response.comments_get_500",
  ]

  http_method       = "${aws_api_gateway_method.comments_get.http_method}"
  resource_id       = "${aws_api_gateway_resource.comments.id}"
  rest_api_id       = "${aws_api_gateway_rest_api.api.id}"
  selection_pattern = "[^0-9](.|\n)*"
  status_code       = "${aws_api_gateway_method_response.comments_get_500.status_code}"
}

resource "aws_api_gateway_method" "comments_get" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = "${aws_api_gateway_resource.comments.id}"
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
}

resource "aws_api_gateway_method_response" "comments_get_200" {
  depends_on  = ["aws_api_gateway_method.comments_get"]
  http_method = "${aws_api_gateway_method.comments_get.http_method}"
  resource_id = "${aws_api_gateway_resource.comments.id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  status_code = 200
}

resource "aws_api_gateway_method_response" "comments_get_500" {
  depends_on  = ["aws_api_gateway_method.comments_get"]
  http_method = "${aws_api_gateway_method.comments_get.http_method}"
  resource_id = "${aws_api_gateway_resource.comments.id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  status_code = 500
}
