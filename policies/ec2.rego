package policies.ec2

import rego.v1

deny contains msg if {
  some resource in input.resource_changes
  resource.type == "aws_instance"
  resource.change.after != null
  resource.change.after.instance_type != "t2.micro"

  msg := sprintf(
    "La instancia %s debe utilizar el tipo t2.micro y no %s",
    [resource.address, resource.change.after.instance_type]
  )
}