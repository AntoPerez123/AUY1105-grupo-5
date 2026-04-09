package policies.sg

deny[msg] if {
  input.resource_type == "aws_security_group"
  ingress := input.values.ingress[_]
  ingress.from_port == 22
  ingress.cidr_blocks[_] == "0.0.0.0/0"
  msg := "No se permite acceso SSH público (0.0.0.0/0)"
}
