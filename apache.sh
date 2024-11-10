#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Retrieve metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
EC2AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id)
AMI_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/ami-id)
INSTANCE_TYPE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-type)
LOCAL_IPV4=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IPV4=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Create HTML output
echo "<body style='background-color:#2c3e50; color:#ffffff'>
        <h1>Deployed via AWS</h1>
        <table border='1' cellpadding='10' style='background-color:#ffffff; color:#000000'>
            <tr><th>Meta-Data</th><th>Value</th></tr>
            <tr><td>Instance ID</td><td>$INSTANCE_ID</td></tr>
            <tr><td>AMI ID</td><td>$AMI_ID</td></tr>
            <tr><td>Instance Type</td><td>$INSTANCE_TYPE</td></tr>
            <tr><td>Availability Zone</td><td>$EC2AZ</td></tr>
            <tr><td>Local IPv4</td><td>$LOCAL_IPV4</td></tr>
            <tr><td>Public IPv4</td><td>$PUBLIC_IPV4</td></tr>
        </table>
      </body>" > /var/www/html/index.html

