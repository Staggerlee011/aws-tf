# EKS

Creates eks cluster

## dependencies

This terraform is dependant on the below:

- core
- sec

## config

- single worker group
  - attaches the eks-sg security group
  - uses private subnet

## security

- adds chris billet manually to admins group
