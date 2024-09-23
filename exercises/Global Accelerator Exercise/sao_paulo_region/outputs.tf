output "instance_public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = [aws_instance.web1.public_ip, aws_instance.web2.public_ip]
}
