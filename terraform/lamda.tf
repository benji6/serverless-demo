data "archive_file" "comments_get" {
  output_path = "../dist/comments_get.zip"
  source_file = "../src/comments_get.py"
  type        = "zip"
}

data "archive_file" "comments_post" {
  output_path = "../dist/comments_post.zip"
  source_file = "../src/comments_post.py"
  type        = "zip"
}

data "archive_file" "triangle_get" {
  output_path = "../dist/triangle_get.zip"
  source_file = "../src/triangle_get.py"
  type        = "zip"
}

resource "aws_lambda_function" "comments_get" {
  filename         = "${data.archive_file.comments_get.output_path}"
  function_name    = "comments_get"
  handler          = "comments_get.handler"
  role             = "${aws_iam_role.lambda_exec.arn}"
  runtime          = "python3.7"
  source_code_hash = "${base64sha256(file("${data.archive_file.comments_get.output_path}"))}"
}

resource "aws_lambda_function" "comments_post" {
  filename         = "${data.archive_file.comments_post.output_path}"
  function_name    = "comments_post"
  handler          = "comments_post.handler"
  role             = "${aws_iam_role.lambda_exec.arn}"
  runtime          = "python3.7"
  source_code_hash = "${base64sha256(file("${data.archive_file.comments_post.output_path}"))}"
}

resource "aws_lambda_function" "triangle_get" {
  filename         = "${data.archive_file.triangle_get.output_path}"
  function_name    = "triangle_get"
  handler          = "triangle_get.handler"
  role             = "${aws_iam_role.lambda_exec.arn}"
  runtime          = "python3.7"
  source_code_hash = "${base64sha256(file("${data.archive_file.triangle_get.output_path}"))}"
}

resource "aws_lambda_permission" "comments_get" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.comments_get.arn}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_deployment.prod.execution_arn}/*/*"
  statement_id  = "AllowAPIGatewayInvoke"
}

resource "aws_lambda_permission" "comments_post" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.comments_post.arn}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_deployment.prod.execution_arn}/*/*"
  statement_id  = "AllowAPIGatewayInvoke"
}

resource "aws_lambda_permission" "triangle_get" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.triangle_get.arn}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_deployment.prod.execution_arn}/*/*"
  statement_id  = "AllowAPIGatewayInvoke"
}
