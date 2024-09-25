output "VPNGWInstanceEIP" {
  description = "Elastic IP assigned to VPNGW-Instance eth0 interface"
  value       = aws_eip.vpc_eip1.public_ip
}

output "AWSInstancePublic" {
  description = "Public IP assigned to AWS-Instance eth0 interface"
  value       = aws_instance.instance3.public_ip
}
