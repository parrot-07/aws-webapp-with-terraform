resource "aws_security_group" "nginx_sg" {
  name = "nginx-sg"
  description = "allow HTTP and SSH"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx_server" {
  ami = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.nginx_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx
              echo "<h1> Hello from Terrafor EC2 + nginx </h1>" > /usr/share/nginx/html/index.html 
              EOF
  tags = {
    Name = "terraform-nginx-server"
  }
}

