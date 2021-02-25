
# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.resource_prefix}-vpc"

  cidr = "10.0.0.0/16"

  azs            = [(var.zone1 != "" ? var.zone1 : data.aws_availability_zones.available.names[0]), (var.zone2 != "" ? var.zone2 : data.aws_availability_zones.available.names[1]), (var.zone3 != "" ? var.zone3 : data.aws_availability_zones.available.names[2])]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  enable_ipv6 = true

  enable_nat_gateway = false
  single_nat_gateway = true

  public_subnet_tags = {
    Name = var.resource_prefix
  }

  tags = {
    ibm-satellite = var.resource_prefix
  }

  vpc_tags = {
    Name = var.resource_prefix
  }
}



