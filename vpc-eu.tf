
module "vpc_eu" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"
  providers = {
    aws = aws.eu
  }
  name = "${local.name}-vpc-eu"
  cidr = "192.168.0.0/16"

  azs             = ["${local.region_us}a", "${local.region_us}b", "${local.region_us}c"]
  private_subnets = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]

  tags = local.tags
}



module "vpc_eu_vpc-endpoints" {
  source             = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  vpc_id             = module.vpc_eu.vpc_id
  security_group_ids = [data.aws_security_group.default.id, aws_security_group.vpc_eu_ping.id]


  endpoints = {
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = module.vpc_eu.private_subnets
      security_group_ids  = [aws_security_group.vpc_eu_tls.id]
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = module.vpc_eu.private_subnets
      security_group_ids  = [aws_security_group.vpc_eu_tls.id]
    },
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = module.vpc_eu.private_subnets
      security_group_ids  = [aws_security_group.vpc_eu_tls.id]
    }
  }

}



data "aws_security_group" "default_eu" {
  name   = "default"
  vpc_id = module.vpc_eu.vpc_id
}


resource "aws_security_group" "vpc_eu_tls" {
  name_prefix = "${local.name}-vpc_eu_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc_eu.vpc_id

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