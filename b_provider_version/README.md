# Provider configuration

Most of the Terraform provider plugins are open source, and the most popular providers release new versions on a regular basis,
containing the latest resources / data sources, as well as updates and bug fixes.

## Goal of this exercise

The `sns.tf` file contains Terraform code to create an SNS topic on AWS, which is a kind of communication channel to which
one can publish and subscribe. Try to apply the code in the folder of this exercise. Why does it fail? How can you fix this? How
can you prevent this from happening in the future?

## Carlos comments:
- `terrafform plan` fails due to an issue in the provider.tf file. Specifically, in the 'provider' node, the current AWS account does not have the 'profile' nor the 'role_arm' defined
- An easy option to successfully run the code is to comment those two nested nodes in the "provider" node
- Another option is to update the AWS as:
- Issue 1 
  - Creating a profile and associating the AWS account under that profile
  - Then updating the `provider.tf` - profile node
- Issue 2
  - The `aws_sns_topic.user_updates.owner` is incorrect as the "owner" attribute does not exist. Instead, the "arn" attribute exists

## New project ideas:
- Project 1
  - Set up an EC2 instance behind a NAT box
  - Adding a key pair for SSH access (if it exists, no need to create a new one)
- Project 2
  - Set up a simple application running in AWS Lambda and storing a file into a S3  bucket
  - Set up SNS to confirm whether the task was successful or not
- Project 3
  - Similar to Project 2 but from a container and using either an EC2 or Fargate
- Project 4
  - All the previous projects but in GCP