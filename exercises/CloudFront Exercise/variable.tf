variable "key_name" {
  description = "The name of the SSH key pair to associate with the EC2 instance."
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key file."
  type        = string
  default     = "/Users/macerpark/Documents/Chungyun.pub" # Set a default path or input during apply
}