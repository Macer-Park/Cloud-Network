output "endpoint_public_ec2_public_ip_address" {
  value       = aws_instance.endpoint_public_ec2.public_ip
  description = "Output for Remote Access via SSH Port 22"
}

output "endpoint_private_ec2_private_ip_address" {
  value       = aws_instance.endpoint_private_ec2.private_ip
  description = "Output for Remote Access via SSH Port 22 from endpoint_public_ec2"
}