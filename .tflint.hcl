config {
  format = "compact"
  plugin_dir = "~/.tflint.d/plugins"

  module = true
}

plugin "aws" {
  enabled = true
  version = "0.18.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}