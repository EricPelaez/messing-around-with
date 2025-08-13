resource "aws_instance" "myserver" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.shrukey.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/legod/.ssh/key") 
    host        = self.public_ip
  }

  # Create the folder first
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ubuntu/Flaskapplication"
    ]
  }


provisioner "file" {
  source      = "C:/Users/legod/OneDrive/Desktop/projects/messing-around-with/terraform/terraform-6/Flaskapplication/app.py"
  destination = "/home/ubuntu/Flaskapplication/app.py"
}


provisioner "remote-exec" {
  inline = [
    "echo 'Hello from the remote instance'",
    "sudo apt update -y",
    "sudo apt-get install -y python3-pip",
    "sudo pip3 install flask",
    "mkdir -p /home/ubuntu/Flaskapplication",
    "mv /home/ubuntu/app.py /home/ubuntu/Flaskapplication/",
    "cd /home/ubuntu/Flaskapplication",
    "nohup python3 -m flask run --host=0.0.0.0 --port=5000 > app.log 2>&1 &"
  ]
}


}
