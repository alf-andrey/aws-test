module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2"

  name        = "${local.name}-us-tgw"
  description = "TGW for us VPCs"

  enable_auto_accept_shared_attachments = false

  vpc_attachments = {
    vpc_us = {
      vpc_id       = module.vpc_us.vpc_id
      subnet_ids   = module.vpc_us.private_subnets
      dns_support  = true
      ipv6_support = false


    },
  }

  tags = local.tags
}

module "tgw_eu" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2"
  providers = {
    aws = aws.eu
  }


  name        = "${local.name}-eu-tgw"
  description = "TGW for eu VPCs"

  enable_auto_accept_shared_attachments = false

  vpc_attachments = {
    vpc_eu = {
      vpc_id       = module.vpc_eu.vpc_id
      subnet_ids   = module.vpc_eu.private_subnets
      dns_support  = true
      ipv6_support = false
    },
  }

  tags = local.tags
}
