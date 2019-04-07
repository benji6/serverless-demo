data "archive_file" "triangle_get" {
  output_path = "../dist/triangle_get.zip"
  source_file = "../src/triangle_get.py"
  type        = "zip"
}

resource "aws_lambda_function" "triangle_get" {
  filename         = "${data.archive_file.triangle_get.output_path}"
  function_name    = "triangle_get"
  handler          = "triangle_get.handler"
  role             = "${aws_iam_role.lambda_exec.arn}"
  runtime          = "python3.7"
  source_code_hash = "${base64sha256(file("${data.archive_file.triangle_get.output_path}"))}"
}

resource "aws_lambda_permission" "triangle_get" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.triangle_get.arn}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_deployment.prod.execution_arn}/*/*"
  statement_id  = "AllowAPIGatewayInvoke"
}
