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
  - In AWS console:
    - Updating the user's permissions so that it can assume a role
    - Updating the role's trusts relationship with the user's ID to accept the association 
  - Then updating the `provider.tf` - role_arm with the ID from the role that will be assumed by the user
- Issue 2
  - The `aws_sns_topic.user_updates.owner` is incorrect as the "owner" attribute does not exist. Instead, the "arn" attribute exists
- Extension
  - Adding a new terraform file to create an EC2 instance and another file to create an S3 bucket
  - Configure SNS to receive a notification when the application running in the EC2 instance successfully send a file to the S3 bucket