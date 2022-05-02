resource "aws_security_group" "ssh" {
  name_prefix = "${var.project}-ssh"
  description = "Allow inbound SSH traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_security_group" "kube-api" {
  name_prefix = "${var.project}-kube-api"
  description = "Allow inbound kube-api traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "kube-api"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.node_subnet.cidr_block]
  }
}

data "aws_subnet" "node_subnet" {
  id = var.node_subnet_id
}
