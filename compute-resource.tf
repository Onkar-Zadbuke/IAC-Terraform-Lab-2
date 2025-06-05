resource "aws_instance" "Jenkins-Server" {

  count = var.count_jenkins_server
  ami  = data.aws_ami.amazon-linux-ami.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = data.aws_subnets.jenkins_subnet.ids[count.index]
  vpc_security_group_ids = [data.aws_security_group.jenkins_sg.id]
  tags = {
    "Name" = "Jenkins-Server-${count.index}"
  }
  user_data = <<-EOF
    #!/bin/bash
    #!/bin/bash
    yum install -y java-17-amazon-corretto.x86_64
    java --version
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum -y upgrade
    yum install -y jenkins
    systemctl start jenkins
    systemctl enable jenkins
EOF

}
