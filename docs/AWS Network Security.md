# AWS Security

## Document
- [IP-Ranges](https://ip-ranges.amazonaws.com/ip-ranges.json)

### VPC
- [VPC Flow Logs](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html) - Using VPC flow logs for IP traffic logging.
- [AWS VPC Traffic Control](https://docs.aws.amazon.com/ko_kr/vpc/latest/userguide/vpc-security-groups.html) - Traffic Control about AWS Resource via Security Group
- [AWS VPC Traffic Control](https://docs.aws.amazon.com/ko_kr/vpc/latest/userguide/vpc-network-acls.html) - Traffic Control about Subnet via Network ACL
- [VPC Logging](https://docs.aws.amazon.com/ko_kr/vpc/latest/userguide/flow-logs.html) - Logging IP Traffic via VPC Flow logs
- [AWS VPC Internal Packet mirroring & Dumping](https://gasidaseo.notion.site/AWS-VPC-packet-mirror-dump-74e1a47686bc4d9f8abd46c4b5b72bcb)

### ACL & Security Groups
- [VPC Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html) - Using security groups to control traffic in VPC.
- [Network ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) - Controlling traffic to subnets using network ACLs.

### WAF & Firewall
- [How to Automatically Update Your Security Groups for Amazon CloudFront and AWS WAF by Using AWS Lambda](https://aws.amazon.com/ko/blogs/security/how-to-automatically-update-your-security-groups-for-amazon-cloudfront-and-aws-waf-by-using-aws-lambda/)
- [How to enhance Amazon CloudFront origin security with AWS WAF and AWS Secrets Manager](https://aws.amazon.com/ko/blogs/security/how-to-enhance-amazon-cloudfront-origin-security-with-aws-waf-and-aws-secrets-manager/)
- [The Story that Management of AWS WAF on Woowabros](https://woowabros.github.io/security/2020/10/15/woowa-aws-waf.html)
- [Use Contributor Insights to analyze AWS Network Firewall](https://aws.amazon.com/ko/blogs/mt/use-contributor-insights-to-analyze-aws-network-firewall/)
- [AWS Network Firewall](https://aws.amazon.com/ko/blogs/korea/aws-network-firewall-new-managed-firewall-service-in-vpc/)
- [Deployment models for AWS Network Firewall](https://aws.amazon.com/ko/blogs/networking-and-content-delivery/deployment-models-for-aws-network-firewall/)
- [Automatically block suspicious traffic with AWS Network Firewall & Amazon GuardDuty](https://aws.amazon.com/ko/blogs/security/automatically-block-suspicious-traffic-with-aws-network-firewall-and-amazon-guardduty/)
- [What is AWS Network Firewall?](https://docs.aws.amazon.com/ko_kr/network-firewall/latest/developerguide/what-is-aws-network-firewall.html)
- [AWS Network Firewall resource type reference](https://docs.aws.amazon.com/ko_kr/AWSCloudFormation/latest/UserGuide/AWS_NetworkFirewall.html)
- [AWS Network Firewall Partners](https://aws.amazon.com/ko/network-firewall/partners/)
- [Splunk Named Launch Partner of AWs Network Firewall](https://www.splunk.com/en_us/blog/partners/splunk-named-launch-partner-of-aws-network-firewall.html)
- [Full VPC traffic visibility with AWS Network Firewall and Sumo Logic](https://www.sumologic.com/blog/aws-network-firewall-security/)
- [Announcing Support for AWS Network Firewall in the Terraform AWS Provider](https://www.hashicorp.com/blog/announcing-support-for-aws-network-firewall-in-the-terraform-aws-provider)

### System & Session Manager
- [What is AWS System Manager?](https://docs.aws.amazon.com/ko_kr/systems-manager/latest/userguide/what-is-systems-manager.html)
- [What is AWS Session Manager?](https://docs.aws.amazon.com/ko_kr/systems-manager/latest/userguide/session-manager.html) 
- [Control permission accept & deny of SSH Connection via Session Manager](https://docs.aws.amazon.com/ko_kr/systems-manager/latest/userguide/session-manager-getting-started-enable-ssh-connections.html)
- [Replacing a Bastion Host with Amazon EC2 Systems Manager](https://aws.amazon.com/ko/blogs/mt/replacing-a-bastion-host-with-amazon-ec2-systems-manager/)
- [AWS Systems Manager Session Manager for Shell Access to EC2 Instances](https://aws.amazon.com/ko/blogs/aws/new-session-manager/)
- [Port Forwarding Using AWS System Manager Session Manager](https://aws.amazon.com/ko/blogs/aws/new-port-forwarding-using-aws-system-manager-sessions-manager/)
- [Amazon EC2 instance port forwarding with AWS Systems Manager](https://aws.amazon.com/ko/blogs/mt/amazon-ec2-instance-port-forwarding-with-aws-systems-manager/)
- [Automated configuration of Session Manager without an internet gateway](https://aws.amazon.com/ko/blogs/mt/automated-configuration-of-session-manager-without-an-internet-gateway/)
- [Connect EC2 Instance via AWS System Session Manager (substituion of SSH)](https://musma.github.io/2019/11/29/about-aws-ssm.html)
- [SSH Port Forwarding](https://jusths.tistory.com/102)

### ELB
- [CloudFront - Strengthening security when configuring ALB](https://gasidaseo.notion.site/CloudFront-ALB-f0086dec48b64f0883e0c6de5fd9da4c)
- [AWS CloudFront custom header ALB Filter](https://linuxer.name/2020/10/aws-cloudfront-custom-header-alb-filter/)
- [By introduction of Desync Mitigation Mode that can add Deep Dive Shield on ALB & CLB](https://aws.amazon.com/ko/about-aws/whats-new/2020/08/application-and-classic-load-balancers-adding-defense-in-depth-with-introduction-of-desync-mitigation-mode/)
- [AWS/HTTP-Desync-Guardian](https://github.com/aws/http-desync-guardian)
- [AWS launches open source tool to protect against HTTP request smuggling attacks](https://portswigger.net/daily-swig/aws-launches-open-source-tool-to-protect-against-http-request-smuggling-attacks)

### Alarm & Monitoring
- [Subscribe to AWS Public IP Address Changes via Amazon SNS](https://aws.amazon.com/ko/blogs/aws/subscribe-to-aws-public-ip-address-changes-via-amazon-sns/)
- [Monitor AWS Network Firewall With Datadog](https://www.datadoghq.com/blog/aws-network-firewall/)

### HTTP(S)
- [What is HTTP request smuggling?](https://portswigger.net/web-security/request-smuggling)
- [Web Desync Attack](https://velog.io/@woounnan/WEB-Desync-Attack)
- [HTTP Desync Attcks](https://portswigger.net/research/http-desync-attacks-request-smuggling-reborn)
- [HTTP Desync Attacks in the Wild and How to Defend Against Them](https://www.imperva.com/blog/archive/http-desync-attacks-and-defence-methods/)
- [RFC 7230 - Hypertext Transfer Protocol (HTTP/1.1)](https://datatracker.ietf.org/doc/html/rfc7230)

### Video
- [VPC Packet](https://www.youtube.com/watch?v=ZnB_-kumpVo) - Stateless Packet Filter versus Stateful Packet Inspection
- [Use AWS Management Console and EC2 Instances as Company Account and Password](https://www.youtube.com/watch?v=osSkxPm2CFA&t=910s)

### Lab
- [Hands on Network Firewall Workshop](https://catalog.us-east-1.prod.workshops.aws/workshops/d071f444-e854-4f3f-98c8-025fa0d1de2f/en-US/introduction)