locals {
    lambda_zip_location="outputs/welcome.zip"
}

data "archive_file" "welcome" {
  type        = "zip"
  source_file = "welcome.py"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "${local.lambda_zip_location}"
  function_name = "python-app"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "welcome.hello"

  #source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.7"

}