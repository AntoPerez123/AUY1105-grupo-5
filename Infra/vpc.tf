module "redes" {
  source = "github.com/AntoPerez123/terraform-aws-vpc-AUY1105-antonia?ref=v1.0.0"

  project_name      = "auy1105-antonia"
  vpc_cidr          = "10.0.0.0/16"
  subnet_cidr       = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  ssh_cidr          = "10.0.0.0/16"
  http_cidr         = "0.0.0.0/0"
}