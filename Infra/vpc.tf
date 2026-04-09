resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "AUY1105-grupo5-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "AUY1105-grupo5-subnet"
  }
}

resource "aws_security_group" "sg" {
  description = "Security group for EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  tags = {
    Name = "AUY1105-grupo5-sg"
  }
}

# KMS para logs
resource "aws_kms_key" "log_key" {
  description = "KMS key for VPC flow logs"
}

# CloudWatch corregido
resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name              = "/aws/vpc/flowlogs"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.log_key.arn
}

#  IAM role para flow logs
resource "aws_iam_role" "flow_log_role" {
  name = "flow-log-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "vpc-flow-logs.amazonaws.com"
      }
    }]
  })
}

# Flow log con dependencia
resource "aws_vpc_flow_log" "flow_log" {
  vpc_id          = aws_vpc.main.id
  log_destination = aws_cloudwatch_log_group.vpc_log_group.arn
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  traffic_type    = "ALL"

  depends_on = [aws_cloudwatch_log_group.vpc_log_group]
}

#  Default SG restringido
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress = []
  egress  = []
}
