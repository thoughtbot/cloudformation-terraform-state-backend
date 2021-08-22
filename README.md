# Terraform Backend Cloudformation Template

This Cloudformation template creates an S3 bucket and DynamoDB table suitable
for a [Terraform S3 State Backend]. Using this template avoids the problem of
needing to use a Terraform module to create a state backend before you have a
state backend for that module.

Features:

* Encrypts Terraform state using a dedicated KMS key.
* Creates a dedicated IAM role with only the permissions needed to manage
  Terraform state.
* Sets up S3 access logging for the state bucket.

Parameters:

* __`Name`__: Name of the S3 bucket, DynamoDB table, and IAM role.

Resources:

* __`KMSKey`__ (`AWS::KMS::Key`): KMS key used to encrypt Terraform state
* __`KMSKeyAlias`__ (`AWS::KMS::Alias`): alias for the KMS key
* __`LockTable`__ (`AWS::DynamoDB::Table`): DynamoDB table to lock Terraform
  state
* __`LogBucket`__ (`AWS::S3::Bucket`): bucket for Terraform state access logs
* __`LogBucketPolicy`__ (`AWS::S3::BucketPolicy`): policy to allow IAM users to
  read access logs
* __`Role`__ (`AWS::IAM::Role`): IAM role for managing Terraform state
* __`StateBucket`__ (`AWS::S3::Bucket`): Bucket containing Terraform state
* __`StateBucketPolicy`__ (`AWS::S3::BucketPolicy`): Policy requiring encryption
  for Terraform state

Outputs:

* __`KmsKeyAlias`__: Alias of the KMS key used to encrypt Terraform state.
* __`KmsKeyId`__: ID of the KMS key used to encrypt Terraform state.
* __`LockTableName`__: Name of the DynamoDB table used to lock Terraform state.
* __`Region`__: Region in which the S3 state backend resources are created.
* __`RoleArn`__: ARN of the IAM role capable of managing Terraform state.
* __`StateBucketName`__: Name of the S3 bucket containing Terraform state.

Capabilities:

* __`CAPABILITY_NAMED_IAM`__: Required to create the dedicated IAM role.

[Terraform S3 State Backend]: https://www.terraform.io/docs/language/settings/backends/s3.html
