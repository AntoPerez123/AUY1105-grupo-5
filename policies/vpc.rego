package policies.vpc

deny[msg] {
  input.resource_type == "aws_vpc"
  not input.values.enable_dns_support
  msg = "La VPC debe tener DNS support habilitado"
}

deny[msg] {
  input.resource_type == "aws_vpc"
  not input.values.enable_dns_hostnames
  msg = "La VPC debe tener DNS hostnames habilitado"
}
