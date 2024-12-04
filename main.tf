resource "aws_instance" "jenkins-server" {
  ami           = "ami-0ed83e7a78a23014e"
  instance_type = "t2.micro"
  key_name      = "jenkins-deploy"
  tags = {
    Name = "Myweek20project"
  }
  user_data = file("./scripts/jenkins-install.sh")
}

# security group

resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "Allow ports SSH 22 JENKINS 8080"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "jenkins_url" {
  value = "http://${aws_instance.jenkins-server.public_ip}:8080"
  description = "URL to access to jenkins"
}