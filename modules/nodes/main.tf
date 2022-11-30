resource "aws_instance" "ec2" {
  count = var.node_count

  ami                         = var.node_ami
  instance_type               = var.node_instance_type
  subnet_id                   = var.node_subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  vpc_security_group_ids = [
    aws_security_group.ssh.id, aws_security_group.kube-api.id
  ]

  root_block_device {
    delete_on_termination = true
    volume_size           = var.node_disk_size
    volume_type           = "gp2"
  }

  depends_on = [aws_security_group.ssh]

  provisioner "file" {
    source      = "scripts"
    destination = "./"

    connection {
      type        = "ssh"
      user        = var.node_username
      private_key = file(var.node_ssh_privatekey)
      host        = self.public_dns
    }
  }

  lifecycle {
    ignore_changes = [iam_instance_profile]
  }

  tags = {
    Name = "${var.node_name}-${var.node_count}"
  }
}

output "node_ips" {
  value = aws_instance.ec2[*].public_ip
}