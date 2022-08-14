module "vpc_us_vpc-endpoints" {
  source             = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  vpc_id             = module.vpc_us.vpc_id
  security_group_ids = [data.aws_security_group.default.id, aws_security_group.vpc_ping.id]


  endpoints = {
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = module.vpc_us.private_subnets
      security_group_ids  = [aws_security_group.vpc_tls.id]
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = module.vpc_us.private_subnets
      security_group_ids  = [aws_security_group.vpc_tls.id]
    },
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = module.vpc_us.private_subnets
      security_group_ids  = [aws_security_group.vpc_tls.id]
    }
  }

}

module "vpc_eu_vpc-endpoints" {
  source             = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  vpc_id             = module.vpc_eu.vpc_id
  security_group_ids = [data.aws_security_group.default_eu.id, aws_security_group.vpc_eu_ping.id, aws_security_group.vpc_eu_tls.id]
  providers = {
    aws = aws.eu
  }

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
