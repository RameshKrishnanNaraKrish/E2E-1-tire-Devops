# Create a ec2_instance
resource "aws_instance" "ec2_instance" {
  count                       = length(var.instance_type)
  ami                         = var.ami_id
  instance_type               = var.instance_type[count.index]
  key_name                    = "mykey"
  associate_public_ip_address = "true"

  tags = {
    Name = "Instance ${var.instance_type[count.index]} terraform"
  }
}