# Terraform Backend Cloudformation Template

[![Launch Stack][launch-stack-image]][launch-stack-link]

[launch-stack-image]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/images/cloudformation-launch-stack-button.png
[launch-stack-link]: https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=terraform-state-backend&templateURL=https://terraform-state-backend-templates.s3.amazonaws.com/branch/main/terraform-state-backend.template

This Cloudformation template creates an S3 bucket and DynamoDB table suitable
for a [Terraform S3 State Backend]. Using this template avoids the problem of
needing to use a Terraform module to create a state backend before you have a
state backend for that module.

### Features

* Encrypts Terraform state using a dedicated KMS key.
* Creates a dedicated IAM role with only the permissions needed to manage
  Terraform state.
* Sets up access logging for the state bucket using CloudTrail.

### Parameters

* __`AdminConditionTag`__ (`String`): If Enabled, principals will need to have the tag "Repository" with a value containing Repository in order to assume the role.
* __`AdminPrincipal`__ (`String`): IAM principal allowed to assume the state management role as a human operator; defaults to the current AWS account.
* __`ExecutionConditionTag`__ (`String`): If Enabled, principals will need to have the tag "Repository" with a value containing Repository in order to assume the role.
* __`ExecutionPrincipal`__ (`String`): IAM principal allowed to assume the state management for running Terraform; defaults to the current AWS account.
* __`LogsArchiveInDays`__ (`Number`): Number of days after which logs are moved to glacier storage
* __`LogsDeleteInDays`__ (`Number`): Number of days after which logs are deleted
* __`LogsGroup`__ (`String`): Set to Disabled to disable the Cloudwatch log group
* __`LogsObjectLockInDays`__ (`Number`): Number of days for which log objects are locked
* __`Name`__ (`String`): Name of the S3 bucket, DynamoDB table, and IAM role; Defaults to "terraform-state-AWS_ACCOUNT_ID"
* __`NoncurrentVersionExpirationInDays`__ (`Number`): Number of days after which older state versions are purged
* __`Repository`__ (`String`): Value for the Repository tag; defaults to Name.
* __`SSOPermissionSet`__ (`String`): If provided, IAM roles created from this permission set will be allowed to access Terraform state.
* __`StateVpcId`__ (`String`): If provided, state can access only from the given VPC.

### Resources

* __`KMSKey`__ (`AWS::KMS::Key`): KMS key used to encrypt Terraform state
* __`KMSKeyAlias`__ (`AWS::KMS::Alias`): Alias for the KMS key
* __`LockTable`__ (`AWS::DynamoDB::Table`): DynamoDB table to lock Terraform
* __`Role`__ (`AWS::IAM::Role`): IAM role for managing Terraform state
* __`StateBucket`__ (`AWS::S3::Bucket`): Bucket containing Terraform state
* __`StateBucketPolicy`__ (`AWS::S3::BucketPolicy`): Policy requiring encryption
* __`StateTrail`__ (`AWS::CloudTrail::Trail`): trail logging data events for
* __`TrailBucket`__ (`AWS::S3::Bucket`): Bucket for Terraform state Cloudtrail
* __`TrailBucketPolicy`__ (`AWS::S3::BucketPolicy`): Policy to allow Cloudtrail
* __`TrailLogGroup`__ (`AWS::Logs::LogGroup`): CloudWatch log group for state changes
* __`TrailRole`__ (`AWS::IAM::Role`): IAM role assumed by CloudTrail to write state logs

### Outputs

* __`KmsKeyAlias`__: Alias of the KMS key used to encrypt Terraform state
* __`KmsKeyId`__: ID of the KMS key used to encrypt Terraform state
* __`LockTableName`__: Name of the DynamoDB table used to lock Terraform state
* __`LogGroup`__: CloudWatch log group for state changes
* __`Region`__: Region in which the S3 state backend resources are created
* __`RoleArn`__: ARN of the IAM role capable of managing Terraform state
* __`StateBucketName`__: Name of the S3 bucket containing Terraform state

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
      deploy_method: stack_set
      deployment_targets:
        organizational_units:
        - Workloads
      resource_file: https://s3.us-east-1.amazonaws.com/terraform-state-backend-templates/branch/main/terraform-state-backend.template
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

<!-- START /templates/footer.md -->
## About thoughtbot

![thoughtbot](https://thoughtbot.com/thoughtbot-logo-for-readmes.svg)

This repo is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software!
See [our other projects][community].
We are [available for hire][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com/hire-us?utm_source=github


<!-- END /templates/footer.md -->
