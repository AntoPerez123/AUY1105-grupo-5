package policies.ec2

deny[msg] {
  input.resource_type == "aws_instance"
  not input.values.instance_type == "t2.micro"
  msg = "La instancia EC2 debe ser t2.micro"
}

deny[msg] {
  input.resource_type == "aws_instance"
  not input.values.monitoring
  msg = "EC2 debe tener monitoring activado"
}