# dev playground

quick spin up of a dev playground to run eks and rds from. because if layed build you dont need to use build out the rds + eks, you can deploy either or both. you just need the vpc created first.

    NOTES: region is not defined in providers as its taken from AWS_DEFAULT_REGION 

## vpc

creates vpc, subnets and connectivity

### steps to setup

- `cd 00-vpc`
- `terraform init`
- `terraform apply -auto-aprove`

## eks

creates eks environment

    ONLY RUNS ON LINUX ! ! ! 

### steps to setup

- `cd 01-eks`
- `terraform init`
- `terraform apply -auto-aprove`

## rds

creates eks environment

### steps to setup

- `cd 01-rds`
- `terraform init`
- `terraform apply -auto-aprove`