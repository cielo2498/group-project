# Terraform Config file (main.tf). This has provider block (AWS) and config for provisioning one EC2 instance resource.  

terraform {
required_providers {
  aws = {
  source = "hashicorp/aws"
  version = ">= 3.27"
 }
}

  required_version = ">=0.14"
} 


data "terraform_remote_state" "public1" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "prjs3-1"            // Bucket from where to GET Terraform State
    key    = "terraform.tfstate1" // Object name in the bucket to GET Terraform State  key    = "dev/network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                       // Region where bucket created
  }
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Define tags locally
locals {
  default_tags = merge(var.default_tags, { "env" = var.env })
  name_prefix  = "${var.prefix}-${var.env}"
}


# Create a route table for the private subnets
#resource "aws_route_table" "private_subnet" {
#  vpc_id = "vpc-0aa56a7c2928a7afa"
#  tags = {
 #   Name = "${var.env}-route-private-subnets"
#  }
#}

# Associate the private subnet1 with the private route table
#resource "aws_route_table_association" "private_subnet1" {
#  subnet_id      = aws_subnet.private_subnet1.id
#  route_table_id = aws_route_table.private_subnet.id
#}

# Associate the private subnet2 with the private route table
#resource "aws_route_table_association" "private_subnet2" {
#  subnet_id      = aws_subnet.private_subnet2.id
 # route_table_id = aws_route_table.private_subnet.id
#}


# Create Internet Gateway
#resource "aws_internet_gateway" "igw" {

  #tags = merge(local.default_tags,
 #   {
#      "Name" = "${var.prefix}-igw"
#    }
#  )
#}

# Route table to route add default gateway pointing to Internet Gateway (IGW)
#resource "aws_route_table" "public_subnets" {
 # vpc_id = var.vpc_id
 # vpc_id = aws_vpc.main.id
#  route {
 #   cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.igw.id
 # }
 # tags = {
 #   Name = "${var.env}-route-public-subnets"
#  }
#}

# Associate subnets with the custom route table
#resource "aws_route_table_association" "public_route_table_association" {
 # count          = length(aws_subnet.public_subnet[*].id)
 # route_table_id = aws_route_table.public_subnets.id
 # subnet_id      = aws_subnet.public_subnet[count.index].id
#}


resource "aws_instance" "webserver1" {
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = lookup(var.instance_type, var.env)
    key_name               = aws_key_pair.prj.key_name
    security_groups        = [aws_security_group.AcsPrj.id]
    subnet_id              = data.terraform_remote_state.public1.outputs.public_subnet_ids[0]
   # subnet_id              = "subnet-09b83d8871dd1bd37"
    associate_public_ip_address = false
    user_data = templatefile("${path.module}/install_httpd.sh.tpl",
    {
      env    = upper(var.env),
      prefix = upper(var.prefix)
    }
  )
  root_block_device {
     encrypted = var.env == "prod" ? true : false
     }

   lifecycle {
    create_before_destroy = true
   }  

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux"
    }
  )
}

  resource "aws_instance" "webserver2" {
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = lookup(var.instance_type, var.env)
    key_name               = aws_key_pair.prj.key_name
    security_groups        = [aws_security_group.AcsPrj.id]
    subnet_id              = data.terraform_remote_state.public1.outputs.public_subnet_ids[1]
   # subnet_id              = "subnet-09b83d8871dd1bd37"
    associate_public_ip_address = false
    user_data = templatefile("${path.module}/install_httpd.sh.tpl",
    {
      env    = upper(var.env),
      prefix = upper(var.prefix)
    }
  )
  
     root_block_device {
     encrypted = var.env == "prod" ? true : false
     }

   lifecycle {
    create_before_destroy = true
   }  

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux"
    }
  )
}

 resource "aws_instance" "webserve3" {
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = lookup(var.instance_type, var.env)
    key_name               = aws_key_pair.prj.key_name
    security_groups        = [aws_security_group.AcsPrj.id]
    subnet_id              = data.terraform_remote_state.public1.outputs.public_subnet_ids[2]
   # subnet_id              = "subnet-09b83d8871dd1bd37"
    associate_public_ip_address = false
    user_data = templatefile("${path.module}/install_httpd.sh.tpl",
    {
      env    = upper(var.env),
      prefix = upper(var.prefix)
    }
  )
  
     root_block_device {
     encrypted = var.env == "prod" ? true : false
     }

   lifecycle {
    create_before_destroy = true
   }  

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux"
    }
  )
}

 resource "aws_instance" "webserver4" {
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = lookup(var.instance_type, var.env)
    key_name               = aws_key_pair.prj.key_name
    security_groups        = [aws_security_group.AcsPrj.id]
    subnet_id              = data.terraform_remote_state.public1.outputs.public_subnet_ids[3]
   # subnet_id              = "subnet-09b83d8871dd1bd37"
    associate_public_ip_address = false
    user_data = templatefile("${path.module}/install_httpd.sh.tpl",
    {
      env    = upper(var.env),
      prefix = upper(var.prefix)
    }
  )
  
     root_block_device {
     encrypted = var.env == "prod" ? true : false
     }

   lifecycle {
    create_before_destroy = true
   }  

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux"
    }
  )
}


# Adding SSH  key to instance
resource "aws_key_pair" "prj" {
  key_name   = var.prefix
  public_key = file("${var.prefix}.pub")
}

#security Group
resource "aws_security_group" "AcsPrj" {
  name        = "allow_http_ssh"
  description = "Allow HTTP and SSH inbound traffic"
  #vpc_id      = data.terraform_remote_state.public1.outputs.vpc_id 

  ingress {
    description      = "HTTP from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-EBS"
    }
  )
}


# Elastic IP
resource "aws_eip" "static_eip" {
  instance = aws_instance.webserver1.id
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-eip"
    }
  )
}

# # Attach EBS volume
# resource "aws_volume_attachment" "ebs_att" {
#   count       = var.env == "prod" ? 1 : 0
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.web_ebs[count.index].id
#   instance_id = aws_instance.acs73026.id
# }

# # Create another EBS volume
# resource "aws_ebs_volume" "web_ebs" {
#   count             = var.env == "prod" ? 1 : 0
#   availability_zone = data.aws_availability_zones.available.names[1]
#   size              = 40

#   tags = merge(local.default_tags,
#     {
#       "Name" = "${var.prefix}-EBS"
#     }
#   )
# }
