# Terraform Backend Cloudformation Template

[![Launch Stack][launch-stack-image]][launch-stack-link]

[launch-stack-image]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/images/cloudformation-launch-stack-button.png
[launch-stack-link]: https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=terraform-state-backend&templateURL=https://terraform-state-backend-templates.s3.amazonaws.com/branch/main/terraform-state-backend.template

This Cloudformation template creates an S3 bucket and DynamoDB table suitable
for a [Terraform S3 State Backend]. Using this template avoids the problem of
needing to use a Terraform module to create a state backend before you have a
state backend for that module.

### Features:

* Encrypts Terraform state using a dedicated KMS key.
* Creates a dedicated IAM role with only the permissions needed to manage
  Terraform state.
* Sets up access logging for the state bucket using CloudTrail.

### Parameters:

* __`Name`__: Name of the S3 bucket, DynamoDB table, and IAM role. If not
  specified, names will be generated based on the AWS account ID.

### Resources:

* __`KMSKey`__ (`AWS::KMS::Key`): KMS key used to encrypt Terraform state
* __`KMSKeyAlias`__ (`AWS::KMS::Alias`): alias for the KMS key
* __`LockTable`__ (`AWS::DynamoDB::Table`): DynamoDB table to lock Terraform
  state
* __`Role`__ (`AWS::IAM::Role`): IAM role for managing Terraform state
* __`StateBucket`__ (`AWS::S3::Bucket`): Bucket containing Terraform state
* __`StateBucketPolicy`__ (`AWS::S3::BucketPolicy`): Policy requiring encryption
  for Terraform state
* __`StateTrail`__ (`AWS::CloudTrail::Trail`): trail logging data events for
  the Terraform state bucket
* __`TrailBucket`__ (`AWS::S3::Bucket`): bucket for Terraform state Cloudtrail
  logs
* __`TrailBucketPolicy`__ (`AWS::S3::BucketPolicy`): policy to allow Cloudtrail
  to write log entries

### Outputs:

* __`KmsKeyAlias`__: Alias of the KMS key used to encrypt Terraform state.
* __`KmsKeyId`__: ID of the KMS key used to encrypt Terraform state.
* __`LockTableName`__: Name of the DynamoDB table used to lock Terraform state.
* __`Region`__: Region in which the S3 state backend resources are created.
* __`RoleArn`__: ARN of the IAM role capable of managing Terraform state.
* __`StateBucketName`__: Name of the S3 bucket containing Terraform state.

### Capabilities:

* __`CAPABILITY_NAMED_IAM`__: Required to create the dedicated IAM role.

### Cost:

The KMS key provisioned for this stack will cost $1/month. Additional charges
for KMS, DynamoDB, S3, and Cloudtrail may occur but are insignificant.

## Use in Control Tower

If you've deployed [Customizations for Control Tower], you can include this
template in your customized package.

In your manifest, apply the template to any accounts which will contain
resources managed by Terraform:

    - name: TerraformStateBackend
      description: Create a Terraform state backend in each account
      deployment_targets:
        organizational_units:
        - Workloads
      resource_file: https://terraform-state-backend-templates.s3.amazonaws.com/branch/main/terraform-state-backend.template
      regions:
      - us-west-2

Upload your customized package and you'll have a Terraform state backend
automatically created in any of your workload accounts.

[Terraform S3 State Backend]: https://www.terraform.io/docs/language/settings/backends/s3.html
[Customizations for Control Tower]: https://aws.amazon.com/solutions/implementations/customizations-for-aws-control-tower/

## Contributing

Please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

This template is Copyright © 2021 Joe Ferris and thoughtbot. It is free
software, and may be redistributed under the terms specified in the [LICENSE]
file.

[LICENSE]: ./LICENSE

About thoughtbot
----------------

![thoughtbot](https://thoughtbot.com/brand_assets/93:44.svg)

This template is maintained and funded by thoughtbot, inc. The names and logos
for thoughtbot are trademarks of thoughtbot, inc.

We love open source software! See [our other projects][community] or [hire
us][hire] to design, develop, and grow your product.

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com/hire-us?utm_source=github
