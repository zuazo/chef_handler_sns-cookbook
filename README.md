Description
===========
[![Cookbook Version](https://img.shields.io/cookbook/v/chef_handler_sns.svg?style=flat)](https://community.opscode.com/cookbooks/chef_handler_sns)
[![Build Status](http://img.shields.io/travis/onddo/chef_handler_sns-cookbook.svg?style=flat)](https://travis-ci.org/onddo/chef_handler_sns-cookbook)

Chef cookbook to install and enable [chef-handler-sns](http://onddo.github.io/chef-handler-sns/): A simple Chef report handler that reports status of a Chef run through [Amazon SNS](http://aws.amazon.com/sns/). Includes IAM roles support.

[Amazon SNS](http://aws.amazon.com/sns/) can send notifications by SMS, email, [Amazon SQS](http://aws.amazon.com/sqs/) queues or to any HTTP endpoint.

This cookbook has been tested to work with [AWS OpsWorks](http://aws.amazon.com//opsworks/).

Requirements
============

## Cookbooks:

* [xml](https://community.opscode.com/cookbooks/xml)
* [chef_handler](https://community.opscode.com/cookbooks/chef_handler)

Attributes
==========

| Attribute                                   | Default                               | Description                       |
|:--------------------------------------------|:--------------------------------------|:----------------------------------|
| `node['chef_handler_sns']['topic_arn']`     | *required*                            | AWS topic ARN name (required).
| `node['chef_handler_sns']['access_key']`    | *calculated from ohai with IAM roles* | AWS access key (required, but will try to read it from ohai with IAM roles).
| `node['chef_handler_sns']['secret_key']`    | *calculated from ohai with IAM roles* | AWS secret key (required, but will try to read it from ohai with IAM roles). We do not recomend using this attribute, it is better to use [the LWRP](#chef_handler_snstopic_arn).
| `node['chef_handler_sns']['token']`         | *calculated from ohai with IAM roles* | AWS security token (read from ohai with IAM roles). Set to `false` to disable the token detected by ohai.
| `node['chef_handler_sns']['region']`        | *calculated from ohai*                | AWS region.
| `node['chef_handler_sns']['subject']`       | *calculated*                          | Message subject string in erubis format.
| `node['chef_handler_sns']['body_template']` | *calculated*                          | Full path of an erubis template file to use for the message body.
| `node['chef_handler_sns']['supports']`      | `{ 'exception' => true }`             | Type of Chef Handler to register as, ie `:report`, `:exception` or both.
| `node['chef_handler_sns']['version']`       | *latest stable*                       | chef-handler-sns gem version to install.

Recipes
=======

## chef_handler_sns::default

Installs and enables the Chef SNS Handler.

Resources
=========

## chef_handler_sns[topic_arn]

Installs and enables the Chef SNS handler.

### chef_handler_sns Actions

* `enable`: Installs and enables the Chef Handler.

### chef_handler_sns Parameters

| Parameter     | Default                                     | Description                       |
|:--------------|:--------------------------------------------|:----------------------------------|
| topic_arn     | *resource name*                             | AWS topic ARN name (required).
| access_key    | `node['chef_handler_sns']['access_key']`    | AWS access key (required, but will try to read it from ohai with IAM roles).
| secret_key    | `node['chef_handler_sns']['secret_key']`    | AWS secret key (required, but will try to read it from ohai with IAM roles).
| token         | `node['chef_handler_sns']['token']`         | AWS security token (read from ohai with IAM roles). Set to `false` to disable the token detected by ohai.
| region        | `node['chef_handler_sns']['region']`        | AWS region.
| subject       | `node['chef_handler_sns']['subject']`       | Message subject string in erubis format.
| body_template | `node['chef_handler_sns']['body_template']` | Full path of an erubis template file to use for the message body.
| supports      | `node['chef_handler_sns']['supports']`      | Type of Chef Handler to register as, ie `:report`, `:exception` or both.
| version       | `node['chef_handler_sns']['version']`       | chef-handler-sns gem version to install.

AWS Credentials permissions
===========================

If you are using AWS IAM credentials or AWS IAM role credentials, they should have at least the following privileges:

```json
{
  "Statement": [
    {
      "Sid": "Stmt1234",
      "Effect": "Allow",
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws:sns:us-east-1:12341234:MyTopicName"
      ]
    }
  ]
}
```

Usage Examples
==============

## Using Amazon IAM roles

Using `chef_handler_sns` cookbook with IAM roles is rather easy.

### Including in a Cookbook Recipe

First, you need to include this cookbook as a dependency in your cookbook:

```ruby
# metadata.rb
depends 'chef_handler_sns'
```

```ruby
# in your recipe
node['chef_handler_sns']['topic_arn'] = 'arn:aws:sns:us-east-1:12341234:MyTopicName'
include_recipe 'chef_handler_sns::default'
```

### Using the LWRP from a Cookbook Recipe

You can also use the `chef_handler_sns` LWRP directly instead of including the recipe:

```ruby
# metadata.rb
depends 'chef_handler_sns'
```

```ruby
# in your recipe
chef_handler_sns 'arn:aws:sns:us-east-1:12341234:MyTopicName'
```

### Including in the Run List

To include this cookbook directly in your run list, you must set at least the `topic_arn` attribute:

```json
{
  "name": "git.onddo.com",
  [...]
  "normal": {
    "chef_handler_sns": {
      "topic_arn": "arn:aws:sns:us-east-1:12341234:MyTopicName"
    }
  },
  "run_list": [
    [...]
    "recipe[chef_handler_sns]"
  ]
}
```

## Passing the AWS credentials (machines without IAM roles)

If you are using Amazon EC2 without IAM roles or machines from other providers outside AWS, you must set the AWS credentials: `access_key` and `secret_key` (and sometimes also `token`).

### Using the LWRP from a Cookbook Recipe

```ruby
# metadata.rb
depends 'chef_handler_sns'
```

```ruby
# in your recipe
chef_handler_sns 'arn:aws:sns:us-east-1:12341234:MyTopicName' do
  access_key '***AMAZON-KEY***'
  secret_key '***AMAZON-SECRET***'
end
```

### Installing old versions

If you are not using IAM roles and you don't need to use AWS security tokens, you can use old versions of `chef-handler-sns` (`< 1.0.0`). Those versions does not require `nokogiri`, so they have lighter dependencies and take less time to install.

```ruby
chef_handler_sns 'arn:aws:sns:us-east-1:12341234:MyTopicName' do
  access_key '***AMAZON-KEY***'
  secret_key '***AMAZON-SECRET***'
  version '0.2.6'
end
```

Testing
=======

See [TESTING.md](https://github.com/onddo/chef_handler_sns-cookbook/blob/master/TESTING.md).

Contributing
============

Please do not hesitate to [open an issue](https://github.com/onddo/chef_handler_sns-cookbook/issues/new) with any questions or problems.

See [CONTRIBUTING.md](https://github.com/onddo/chef_handler_sns-cookbook/blob/master/CONTRIBUTING.md).

TODO
====

See [TODO.md](https://github.com/onddo/chef_handler_sns-cookbook/blob/master/TODO.md).

License and Author
==================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Xabier de Zuazo (<xabier@onddo.com>)
| **Copyright:**       | Copyright (c) 2014 Onddo Labs, SL. (www.onddo.com)
| **License:**         | Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
        http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
