module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.cidr
  networks = [
    {
      name     = var.aza
      new_bits = 8
    },
    {
      name     = var.azb
      new_bits = 8
    },
  ]
}

resource "aws_subnet" "example" {
  for_each = module.subnet_addrs.network_cidr_blocks

  vpc_id            = module.vpc.vpc_id
  availability_zone = each.key
  cidr_block        = each.value
}









