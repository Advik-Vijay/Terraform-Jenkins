#Ec2 Instance in Public Subnet
resource "aws_instance" "vijay-ec2" {
  ami                         = "ami-06b6e5225d1db5f46"
  instance_type               = "t2.micro"
  key_name                    = "Terraform"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  user_data                   = file("./apache-install.sh")
  tags = {
    Name = "vijay-ec2"
  }

#Connection block
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    password    = ""
    private_key = file("./private-key/Terraform.pem")
  }

  provisioner "file" {
    source      = "./apache-install.sh"
    destination = "/tmp/apache-install.sh"
  }

provisioner "remote-exec" {
  inline = [
    "sleep 120",  # Wait for Apache to finish provisioning from user_data
    "sudo cp /tmp/apache-install.sh /var/www/html",
    "echo 'Copied Successfully!' | sudo tee /var/www/html/apache-install.sh"
  ]
}
}




