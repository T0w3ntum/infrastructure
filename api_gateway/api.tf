variable target {}
variable name {}
variable aws_access_key {}
variable aws_secret_key {}

provider "aws" {
  access_key  = "${var.aws_access_key}"
  secret_key  = "${var.aws_secret_key}"
}

resource "aws_api_gateway_rest_api" "api" {
 name = "${var.name}"
 description = "Proxy to handle requests to our API"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}
resource "aws_api_gateway_integration" "integration" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_rest_api.api.root_resource_id}"
  http_method = "${aws_api_gateway_method.method.http_method}"
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "${var.target}"

  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = ["aws_api_gateway_integration.integration"]

  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "login"
}

output "url"  {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}"
}
