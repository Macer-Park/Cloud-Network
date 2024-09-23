# Output the EC2 instance public IP
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.SaEC2.public_ip
}
