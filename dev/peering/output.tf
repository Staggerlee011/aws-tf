module "vpc-peering" {
  source  = "grem11n/vpc-peering/aws"
  version = "2.2.3"

  providers = {
    aws.this = aws.this
    aws.peer = aws.peer
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  tags = {
    Name        = "tf-multi-account-multi-region"
    Environment = "Test"
  }
}