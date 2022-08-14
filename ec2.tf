module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "${local.name}-vpc-us-ec2"
  #for_each = toset(data.aws_subnets.subnets_us.ids)

  ami                    = "ami-051dfed8f67f095f5"
  instance_type          = "t2.micro"
  monitoring             = false
  vpc_security_group_ids = [data.aws_security_group.default.id, aws_security_group.vpc_ping.id, aws_security_group.vpc_tls.id]
  subnet_id              = data.aws_subnets.subnets_us.ids[0]

  iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name

  root_block_device = [{
    volume_size = 10
  }]

  tags = local.tags
}

module "ec2_instance_eu" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  providers = {
    aws = aws.eu
  }
  name = "${local.name}-vpc-eu-ec2"

  ami                    = "ami-0c956e207f9d113d5"
  instance_type          = "t2.micro"
  monitoring             = false
  vpc_security_group_ids = [data.aws_security_group.default_eu.id, aws_security_group.vpc_eu_ping.id, aws_security_group.vpc_eu_tls.id]
  subnet_id              = data.aws_subnets.subnets_eu.ids[0]

  iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name


  root_block_device = [{
    volume_size = 10
  }]


  tags = local.tags
}