# Instance type
variable "instance_type" {
  default = {
    "prod"    = "t2.micro"
    "nonprod"    = "t2.micro"
    "test"    = "t2.micro"
    "dev"     = "t2.micro"
  }
  description = "Type of the instance"
  type        = map(string)
}


# Name vpc_id
variable "vpc_id" {
  type        = string
  default     = "vpc-002858f99b9d07269"
  description = "Name vpc_id"
}

