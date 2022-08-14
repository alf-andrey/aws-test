data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc_us.vpc_id
}

data "aws_security_group" "default_eu" {
  name     = "default"
  vpc_id   = module.vpc_eu.vpc_id
  provider = aws.eu
}

resource "aws_security_group" "vpc_tls" {
  name_prefix = "${local.name}-vpc_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc_us.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc_us.vpc_cidr_block]
  }

  tags = local.tags
}

resource "aws_security_group" "vpc_ping" {
  name_prefix = "${local.name}-vpc_ping"
  description = "Allow Ping inbound traffic"
  vpc_id      = module.vpc_us.vpc_id

  ingress {
    description = "Allow echo reply to VPC"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [module.vpc_us.vpc_cidr_block]
  }

  ingress {
    description = "Allow echo request to VPC"
    from_port   = 0
    to_port     = 8
    protocol    = "icmp"
    cidr_blocks = [module.vpc_us.vpc_cidr_block]
  }
  tags = local.tags
}

resource "aws_security_group" "vpc_eu_tls" {
  name_prefix = "${local.name}-vpc_eu_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc_eu.vpc_id
  provider    = aws.eu

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc_eu.vpc_cidr_block]
  }

  tags = local.tags
}

resource "aws_security_group" "vpc_eu_ping" {
  name_prefix = "${local.name}-vpc_eu_ping"
  description = "Allow Ping inbound traffic"
  vpc_id      = module.vpc_eu.vpc_id
  provider    = aws.eu

  ingress {
    description = "Allow echo reply to VPC"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [module.vpc_eu.vpc_cidr_block]
  }

  ingress {
    description = "Allow echo request to VPC"
    from_port   = 0
    to_port     = 8
    protocol    = "icmp"
    cidr_blocks = [module.vpc_eu.vpc_cidr_block]
  }
  tags = local.tags
}
