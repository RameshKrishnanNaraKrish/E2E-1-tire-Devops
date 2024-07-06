resource "aws_instance" "ec2-provisioner-example" {
  count                       = length(var.instance_type)
  ami                         = var.ami_id
  instance_type               = var.instance_type[count.index]
  key_name                    = "mykey"
  associate_public_ip_address = "true"

  tags = {
    Name = "provisioner ${count.index + 1} terraform"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo git clone https://github.com/RameshKrishnanNaraKrish/E2E-1-tire-Devops.git",
      "cd /home/ubuntu/E2E-1-tire-Devops/",
      "sh install-jenkins-terraform.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/nkrk1/Desktop/Devops HW/New folder/mykey.pem")
    host        = self.public_ip
  }
}