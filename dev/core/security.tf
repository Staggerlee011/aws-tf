resource "aws_security_group" "rds" {
  name   = "rds"
  vpc_id = "${module.vpc.vpc_id}"
  tags = {
    Name        = "rds-sg"
    Application = "rds"
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "rds-to-eks-ingress" {
  security_group_id        = aws_security_group.rds.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 5432
  to_port                  = 5432
  source_security_group_id = aws_security_group.eks.id
  description              = "rds to eks"
}

resource "aws_security_group_rule" "rds-egress" {
  security_group_id = aws_security_group.rds.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "outbound traffic"
}

resource "aws_security_group" "eks" {
  name   = "eks"
  vpc_id = "${module.vpc.vpc_id}"
  tags = {
    Name        = "eks-sg"
    Application = "eks"
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "eks-to-rds-ingress" {
  security_group_id        = aws_security_group.eks.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 5432
  to_port                  = 5432
  source_security_group_id = aws_security_group.rds.id
  description              = "eks to rds"
}

resource "aws_security_group_rule" "eks-egress" {
  security_group_id = aws_security_group.eks.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "outbound traffic"
}

