# vpc peering

set up vpc peering using module by Isa Aguilar.

`https://github.com/isaaguilar/terraform-aws-multi-account-peering`

## set up

- aws credentials for the 2 accounts that will be peered should be configured and tested
- run scripts in numerical order
  - 01-vpc-a terraform init, terraform apply (creates the primary vpc)
  - 02-vpc-b terraform init, terraform apply (creates the secondary vpc in a different account)
  - 03-peering terraform init, terraform apply (vpc-peering between primary and secondary)

## notes

- tflint fails on 03-peering due to module not having version. But version constraint errors when not pulling a module from registry :shrug

## missing / cleanup

- remove hardcoded vpc secondary account details from main.tf in 03-peering
- updates ALL route tables. better filtering might be needed in production use cases (see example below)

```terraform
data "aws_route_tables" "rts" {
  vpc_id = "${var.vpc_id}"

  filter {
    name   = "tag:kubernetes.io/kops/role"
    values = ["private*"]
  }
}
```
