variable "ami" {
  type        = string
  description = "Amazon Linux 2 Latest IMG"
  sensitive   = true
}

variable "keypair" {
  type        = string
  description = "Remote Access Key Pair"
  sensitive   = true
}

variable "availability_zone" {
  type        = list(string)
  description = "ap-northeast-2a & 2c region"
  default     = ["ap-northeast-2a"]
}