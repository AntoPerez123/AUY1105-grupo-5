terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "ci_mode" {
  description = "Permite ejecutar validaciones y terraform plan en CI sin conectarse a AWS."
  type        = bool
  default     = false
}

provider "aws" {
  region = "us-east-1"

  skip_credentials_validation = var.ci_mode
  skip_metadata_api_check     = var.ci_mode
  skip_requesting_account_id  = var.ci_mode

  default_tags {
    tags = {
      Project = "AUY1105-grupo5"
    }
  }
}