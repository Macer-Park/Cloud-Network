variable "key_pair" {
  description = "Name of an existing EC2 KeyPair to enable SSH access to the instances."
  type        = string
}

variable "latest_ami_id" {
  description = "Latest Amazon Linux 2 AMI ID."
  type        = string
  default     = "ami-0ee82191e264e07cc"
}

