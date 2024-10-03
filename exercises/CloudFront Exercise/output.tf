output "SA-EC2-IP" {
  description = "Use this IP Address to exercise for CloudFront"
  value       = module.terraform-public-ec2-module-set.public_ip
}