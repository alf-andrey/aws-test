module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.0"

  name        = "${local.name}-tgw"
  description = "TGW for 2 VPC"

  enable_auto_accept_shared_attachments = false

  vpc_attachments = {
    vpc_us = {
      vpc_id       = module.vpc_us.vpc_id
      subnet_ids   = module.vpc_us.private_subnets
      dns_support  = true
      ipv6_support = false


    },
    vpc_eu = {
      vpc_id     = module.vpc_eu.vpc_id
      subnet_ids = module.vpc_eu.private_subnets
      dns_support  = true
      ipv6_support = false     
    },
  }

  tags = local.tags
}
