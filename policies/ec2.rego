package policies.ec2

deny[msg] if {
  input.resource_type == "aws_instance"
  input.values.instance_type != "t2.micro"
  msg := "La instancia EC2 debe ser tipo t2.micro"
}