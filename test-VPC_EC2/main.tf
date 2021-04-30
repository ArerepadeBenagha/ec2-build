# # # Creatin autoscaling for ec2 and elb
# # resource "aws_launch_configuration" "example-launchconfig" {
# #   name_prefix     = "example-launchconfig"
# #   image_id        = var.AMIS[var.AWS_REGION]
# #   instance_type   = var.name
# #   key_name        = aws_key_pair.mykeypair.key_name
# #   security_groups = [aws_security_group.myinstance.id]
# #   user_data       = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
# #   lifecycle {
# #     create_before_destroy = true
# #   }
# # }

# resource "aws_autoscaling_group" "example-autoscaling" {
#   name                      = var.scale
#   vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
#   launch_configuration      = aws_launch_configuration.example-launchconfig.name
#   min_size                  = 2
#   max_size                  = 2
#   health_check_grace_period = 300
#   health_check_type         = "ELB"
#   load_balancers            = [aws_elb.my-elb.name]
#   force_delete              = true

#   tag {
#     key                 = "Name"
#     value               = "ec2 instance"
#     propagate_at_launch = true
#   }
# }

# # creating load balancer
# resource "aws_elb" "my-elb" {
#   name            = var.elb
#   subnets         = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
#   security_groups = [aws_security_group.elb-securitygroup.id]
#   listener {
#     instance_port     = 80
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }
#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     target              = "HTTP:80/"
#     interval            = 30
#   }

#   cross_zone_load_balancing   = true
#   connection_draining         = true
#   connection_draining_timeout = 400
#   tags = {
#     Name = "my-elb"
#   }
# }

# # Creatig security groups

# # resource "aws_security_group" "allow-ssh-login" {
# #   name          = var.ssh
# #   vpc_id        = aws_vpc.main.id
# #   description   = "security group that allows ssh and all egress traffic"
  
# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   ingress {
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
 
# #   ingress {
# #     from_port       = 80
# #     to_port         = 80
# #     protocol        = "tcp"
# #     security_groups = [aws_security_group.elb-securitygroup.id]
# #   }

# #  tags = {
# #     Name = "allow-ssh-login"
# #   }
# # }
# resource "aws_security_group" "elb-securitygroup" {
#   vpc_id      = aws_vpc.main.id
#   name        = var.securitygroup-elb
#   description = "security group for load balancer"
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "elb"
#   }
# }

# resource "aws_security_group" "myinstance" {
#   vpc_id      = aws_vpc.main.id
#   name        = "myinstance"
#   description = "security group for my instance"
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port       = 80
#     to_port         = 80
#     protocol        = "tcp"
#     security_groups = [aws_security_group.elb-securitygroup.id]
#   }

#   tags = {
#     Name = "myinstance"
#   }
# }

# Ec2-instance
resource "aws_instance" "example" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.name
  count         = var.instance_count
  key_name = aws_key_pair.mykeypair.key_name
  tags = {
    Name  = element(var.instance_tags, count.index)
  }
}

# Vars.tf
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags = {
    Name = "main"
  }
}

# Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Main-public-1"
  }
}
resource "aws_subnet" "main-public-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Main-public-2"
  }
}
resource "aws_subnet" "main-public-3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1c"

  tags = {
    Name = "Main-public-3"
  }
}
resource "aws_subnet" "main-private-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Main-private-1"
  }
}
resource "aws_subnet" "main-private-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Main-private-2"
  }
}
resource "aws_subnet" "main-private-3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Main-private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
       subnet_id = aws_subnet.main-public-1.id
       route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-2-a" {
       subnet_id = aws_subnet.main-public-2.id
       route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-3-a" {
       subnet_id = aws_subnet.main-public-3.id
       route_table_id = aws_route_table.main-public.id
}

# Security groups
resource "aws_security_group" "allow-ssh-login" {
  name          = "allow-ssh-login"
  vpc_id        = aws_vpc.main.id
  description   = "security group that allows ssh and all egress traffic"
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
 
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
 tags = {
    Name = "elite-sg"
  }
}

# Keypair
resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file(var.path_to_public_key)
}

# Provider
provider "aws" {
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
    region     = var.AWS_REGION
}

# Output
output "app-ip" {
  value = [aws_instance.example.*.public_ip]
}