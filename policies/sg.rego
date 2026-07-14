package policies.sg

import rego.v1

deny contains msg if {
  some resource in input.resource_changes
  resource.type == "aws_security_group"
  resource.change.after != null

  some rule in resource.change.after.ingress
  rule.from_port <= 22
  rule.to_port >= 22
  "0.0.0.0/0" in rule.cidr_blocks

  msg := sprintf(
    "El Security Group %s permite SSH desde 0.0.0.0/0",
    [resource.address]
  )
}