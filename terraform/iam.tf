resource "aws_iam_role" "lambda_exec" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ]
}
EOF

  name = "lambda_exec_pascals_triangle"
}

resource "aws_iam_role_policy_attachment" "aws_lambda_basic_execution_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = "${aws_iam_role.lambda_exec.name}"
}
