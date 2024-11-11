#!/bin/bash
yum update -y
yum install -y httpd
service httpd start
chkconfig httpd on
echo "<html><body><h1>Welcome to My Website!</h1><p>This content is served by an EC2 instance launched by an Auto Scaling Group.</p></body></html>" > /var/www/html/index.html


