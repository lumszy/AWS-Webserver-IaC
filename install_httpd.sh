#! /bin/bash
sudo yum update
sudo yum install -y httpd
sudo chkconfig httpd on
sudo service httpd start
hostValue=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
echo "<h1>Website is deployed with Terraform with ELB $hostValue</h1>" | sudo tee /var/www/html/index.html