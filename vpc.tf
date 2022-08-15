
module "vpc_us" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3"

  name = "${local.name}-vpc-us"
  cidr = "192.168.0.0/16"

  azs             = ["${local.region_us}a", "${local.region_us}b", "${local.region_us}c"]
  private_subnets = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags

}


module "vpc_eu" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3"
  providers = {
    aws = aws.eu
  }
  name = "${local.name}-vpc-eu"
  cidr = "10.0.0.0/16"

  azs             = ["${local.region_eu}a", "${local.region_eu}b", "${local.region_eu}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags
}







