variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for EC2 insatnce"
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "tags_name" {
  description = "EC2 Virtual Machine in AWS"
  type        = map(string)
  default = {
    Name = "example_ec2"
  }
}

//used secrete keys tot grant access , addtionally can also make use of IAM, in case of dev or prod teams need to access the server
variable "my_secret_key" {
  description = "My secret key"
  type        = string

}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "subnet_cidr" {
  default = "10.1.1.0/24"
}