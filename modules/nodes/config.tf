# SSH TLS keys
resource "aws_key_pair" "ssh-key" {
  key_name   = "${var.node_name}-ssh-key"
  public_key = file(var.node_ssh_publickey)
}