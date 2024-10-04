output "VPNGWInstanceEIP" {
  description = "Elastic IP assigned to VPNGW-Instance eth0 interface"
  value       = aws_instance.Instance1.public_ip
}

output "AWSInstancePublic" {
  description = "Public IP assigned to AWS-Instance eth0 interface"
  value       = aws_instance.Instance3.public_ip
}