variable "region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "ap-southeast-2"
}

variable "public_key_path" {
  description = "The path to the public key file to be used for SSH access"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = []
}
