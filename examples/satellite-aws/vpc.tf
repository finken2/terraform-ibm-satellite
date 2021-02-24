
# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# e.g. Create subnets in the first two available availability zones

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.resource_prefix}-vpc"

  cidr = "10.0.0.0/16"

  azs             = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  enable_ipv6 = true

  enable_nat_gateway = false
  single_nat_gateway = true

  public_subnet_tags = {
    Name = local.resource_prefix
  }

  tags = {
    ibm-satellite = var.location_name
  }

  vpc_tags = {
    Name = local.resource_prefix
  }
}



