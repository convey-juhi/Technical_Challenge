# Three-Tier Web Application

This repository creates the infrastructure for a three-tier web application using Terraform.

The infrastructure is deployed inside a VPC with 2 Public Subnets and 2 Private Subnets across two Availability. The Private subnets can connect to the Internet via the Nat Gateways deployed in their respective Availability Zone. Two NAT Gateways have been created for the purpose of High Availability.

**Tier 1**

This is the Web tier. It contains an Application Load Balancer (External LB) in Public Subnet which connects the users to the to EC2 Instances (Web-Application).The EC2 instance are deployed in two Availability Zones for High Availability and are contained inside an autoscaling group to scale-in and scale-out based on the demand with minimum 2 instances running all the time.

**Tier 2**

This is the App tier. It contains a Network Load Balancer (Internal LB) in Private Subnet which connects the EC2 instance in the Web-Tier to the EC2 instance in the App Tier. Similar to the Web-Tier, the App Tier EC2 instances are also deployed across two availability zone for High Availabilty and are contained with the autoscaling group.  The instances in App-Tier are deployed in Private Subnets.

**Tier 3**

This is the Database Tier. It contains the RDS For MySQL Database Deployed. Only the App-Tier instances can connect to the Database instance.

**Pre-Requisite**

This code needs the following pre-requisites to be completed before running the code :
  1. aws cli is configured.
  2. Terraform is installed.

**Execution Steps**

Step 1 :  Initialize the terraform repository by using the command :
    terraform init
    
Step 2 : Run 'terraform plan' command to verify the resources that will be created by this repository

Step 3:  Run 'terraform apply -auto-approve' to create the infrastructure resources for the Three-Tier Application.

**Resource that will be created**

    1. VPC
    2. Subnets (Public and Private)
    3. Security Groups
    4. Route Tables
    5. Nat Gateways
    6. Internet Gateway
    7. EC2 Instances
    8. Launch Templates
    9. Autoscaling Groups
    10. LoadBalancers
    11. Database

![three-tier-app1 drawio](https://user-images.githubusercontent.com/106310000/171252963-61d45550-b6c0-487c-accc-2900082a48db.png)

