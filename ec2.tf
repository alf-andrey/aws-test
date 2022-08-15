module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3"

  name = "${local.name}-vpc-us-ec2"
  #for_each = toset(data.aws_subnets.subnets_us.ids)

  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  monitoring             = false
  vpc_security_group_ids = [data.aws_security_group.default.id, aws_security_group.vpc_ping.id, aws_security_group.vpc_tls.id]
  subnet_id              = module.vpc_us.private_subnets[1]

  iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name

  root_block_device = [{
    volume_size = 10
  }]

  tags = local.tags
}

module "ec2_instance_eu" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3"
  providers = {
    aws = aws.eu
  }
  name = "${local.name}-vpc-eu-ec2"

  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  monitoring             = false
  vpc_security_group_ids = [data.aws_security_group.default_eu.id, aws_security_group.vpc_eu_ping.id, aws_security_group.vpc_eu_tls.id]
  subnet_id              = module.vpc_eu.private_subnets[2]

  iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name


  root_block_device = [{
    volume_size = 10
  }]


  tags = local.tags
}