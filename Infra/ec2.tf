module "computo" {
  source = "github.com/AntoPerez123/terraform-aws-ec2-AUY1105-antonia?ref=v1.0.0"

  project_name       = "auy1105-antonia"
  ami_id             = "ami-0c02fb55956c7d316"
  instance_type      = "t2.micro"
  subnet_id          = module.redes.subnet_ids[0]
  security_group_ids = [module.redes.security_group_id]
}