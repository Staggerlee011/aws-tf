# Create a route table as main
resource "aws_default_route_table" "config-mgmt-rt-main" {
  default_route_table_id = "${var.default_route_table}" 
    tags = {
    Name = "CONFIG-MGMT-DEFAULT-RT"
  }
}

resource "aws_route_table_association" "config-mgmt-app-az1" {
  subnet_id      = "${aws_subnet.config-mgmt-az1-app.id}"
  route_table_id = "${aws_default_route_table.config-mgmt-rt-main.id}"
}

resource "aws_route_table_association" "config-mgmt-app-az2" {
  subnet_id      = "${aws_subnet.config-mgmt-az2-app.id}"
  route_table_id = "${aws_default_route_table.config-mgmt-rt-main.id}"
}

resource "aws_route_table_association" "config-mgmt-db-az1" {
  subnet_id      = "${aws_subnet.config-mgmt-az1-db.id}"
  route_table_id = "${aws_default_route_table.config-mgmt-rt-main.id}"
}

resource "aws_route_table_association" "config-mgmt-db-az2" {
  subnet_id      = "${aws_subnet.config-mgmt-az2-db.id}"
  route_table_id = "${aws_default_route_table.config-mgmt-rt-main.id}"
}


# Create a route for mgmt network
resource "aws_route" "config-mgmt-mgmt-r" {
  route_table_id            = "${aws_default_route_table.config-mgmt-rt-main.id}"
  destination_cidr_block    = "10.222.0.0/16"
  vpc_peering_connection_id = "pcx-0ff4f1637e9f9e369"
}

# Create a route for logging network
resource "aws_route" "config-mgmt-log-r" {
  route_table_id            = "${aws_default_route_table.config-mgmt-rt-main.id}"
  destination_cidr_block    = "10.231.0.0/16"
  vpc_peering_connection_id = "pcx-029a9ddb668c5fa11"
}

# Create a route for INTER network
resource "aws_route" "config-mgmt-inetr-r" {
  route_table_id            = "${aws_default_route_table.config-mgmt-rt-main.id}"
  destination_cidr_block    = "10.223.0.0/16"
  vpc_peering_connection_id = "pcx-02ed97f46e9d00735"
}

#Create mtcnovo.net DHCP option set - You will need to manaully delete the default VPC
#after running this script for the first time 
resource "aws_vpc_dhcp_options" "config-mgmt-dhcp" {
  domain_name          = "mtcnovo.net"
  domain_name_servers  = ["10.222.1.5", "10.222.21.5"]
  ntp_servers          = ["10.222.2.139", "10.222.22.209"]

  tags = {
    Name = "mtcnovo.net"
  }
}

# VPC to DHCP Option set
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${aws_vpc.config-mgmt-vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.config-mgmt-dhcp.id}"
}

# Security Group for APP instances
resource "aws_security_group" "config-mgmt-sg-app" {
  name        = "CONFIG-MGMT-APP-SG"
  description = "Allow Access from MGMT VPC to Instance"
  vpc_id      = "${aws_vpc.config-mgmt-vpc.id}"

# Allow SSH access to servers from MGMT RDP CONFIG-MGMT Security Group
 ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "TCP"
   security_groups = ["${var.mgmt_config-mgmt_rdp_sg}"]
   description = "Allow SSH from MGMT RDP CONFIG-MGMT VPC"
 }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    security_groups = ["${aws_security_group.config-mgmt-sg-ialb-app.id}"]
    description = "HTTP from Load Balancer"
  }

  ingress {
    from_port   = 10050
    to_port     = 10050
    protocol    = "TCP"
    security_groups = ["${var.zabbix_agent_sg}"]
    description = "Zabbix Agent Connection"
  }

  ingress {
    from_port   = 4118
    to_port     = 4118
    protocol    = "TCP"
    security_groups = ["${var.mgmt_config-mgmt_trend_sg}"]
    description = "Allow Trend Deep Security"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow All"
  }

    tags = {
    Name = "CONFIG-MGMT-APP-SG"
  }
}