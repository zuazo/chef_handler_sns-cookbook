Description
===========

Chef cookbook to install and load chef-handler-sns: A simple Chef report handler that reports status of a Chef run through [Amazon SNS](http://aws.amazon.com/sns/). Includes IAM roles support.

[Amazon SNS](http://aws.amazon.com/sns/) can send notifications by SMS, email, [Amazon SQS](http://aws.amazon.com/sqs/) queues or to any HTTP endpoint.

Requirements
============

## Cookbooks:

* xml
* chef_handler

Attributes
==========

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['chef_handler_sns']['topic_arn']</code></td>
    <td>AWS topic ARN name (required).</td>
    <td><em>required</em></td>
  </tr>
  <tr>
    <td><code>node['chef_handler_sns']['access_key']</code></td>
    <td>AWS access key (required, but will try to read it from ohai with IAM roles).</td>
    <td><em>calculated from ohai with IAM roles</em></td>
  </tr>
  <tr>
    <td><code>node['chef_handler_sns']['secret_key']</code></td>
    <td>AWS secret key (required, but will try to read it from ohai with IAM roles).</td>
    <td><em>calculated from ohai with IAM roles</em></td>
  </tr>
  <tr>
    <td><code>node['chef_handler_sns']['token']</code></td>
    <td>AWS security token (read from ohai with IAM roles).</td>
    <td><em>calculated from ohai with IAM roles</em></td>
  </tr>
  <tr>
    <td><code>node['chef_handler_sns']['region']</code></td>
    <td>AWS region.</td>
    <td><em>calculated from ohai</em></td>
  </tr>
  <tr>
    <td><code>node['chef_handler_sns']['subject']</code></td>
    <td>Message subject string in erubis format.</td>
    <td><em>calculated</em></td>
  </tr>
  <tr>
    <td><code>node['chef_handler_sns']['body_template']</code></td>
    <td>Full path of an erubis template file to use for the message body.</td>
    <td><em>calculated</em></td>
  </tr>
  <tr>
    <td><code>node['chef_handler_sns']['nokogiri']['use_system_libraries']</code></td>
    <td>Prevent nokogiri from compiling libxml2 and libxslt and force to use the system libraries. Should decrease the installation time.</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['chef_handler_sns']['supports']</code></td>
    <td>Type of Chef Handler to register as, ie <code>:report</code>, <code>:exception</code> or <code>both</code>.</td>
    <td><code>{ "exception" => true }</code></td>
  </tr>
  <tr>
    <td><code>node['chef_handler_sns']['version']</code></td>
    <td>chef-handler-sns gem version to install.</td>
    <td><em>latest stable</em></td>
  </tr>
</table>

Recipes
=======

## chef_handler_sns::default

Installs and loads the Chef SNS Handler.

Resources
=========

## chef_handler_sns[topic_arn]

Installs and loads the Chef SNS handler.

### chef_handler_sns actions

* `install`: Installs and loads the handler.

### chef_handler_sns attributes

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td>topic_arn</td>
    <td>AWS topic ARN name (required).</td>
    <td><em>resource name</em></td>
  </tr>
  <tr>
    <td>access_key</td>
    <td>AWS access key (required, but will try to read it from ohai with IAM roles).</td>
    <td><code>node['chef_handler_sns']['access_key']</code></td>
  </tr>
  <tr>
    <td>secret_key</td>
    <td>AWS secret key (required, but will try to read it from ohai with IAM roles).</td>
    <td><code>node['chef_handler_sns']['secret_key']</code></td>
  </tr>
  <tr>
    <td>token</td>
    <td>AWS security token (read from ohai with IAM roles).</td>
    <td><code>node['chef_handler_sns']['token']</code></td>
  </tr>
  <tr>
    <td>region</td>
    <td>AWS region.</td>
    <td><code>node['chef_handler_sns']['region']</code></td>
  </tr>
  <tr>
    <td>subject</td>
    <td>Message subject string in erubis format.</td>
    <td><code>node['chef_handler_sns']['subject']</code></td>
  </tr>
  <tr>
    <td>body_template</td>
    <td>Full path of an erubis template file to use for the message body.</td>
    <td><code>node['chef_handler_sns']['body_template']</code></td>
  </tr>
  <tr>
    <td>nokogiri_use_system_libraries</td>
    <td>Prevent nokogiri from compiling libxml2 and libxslt and force to use the system libraries. Should decrease the installation time.</td>
    <td><code>node['chef_handler_sns']['nokogiri']['use_system_libraries']</code></td>
  </tr>
  <tr>
    <td>supports</td>
    <td>Type of Chef Handler to register as, ie <code>:report</code>, <code>:exception</code> or <code>both</code>.</td>
    <td><code>node['chef_handler_sns']['supports']</code></td>
  </tr>
  <tr>
    <td>version</td>
    <td>chef-handler-sns gem version to install.</td>
    <td><code>node['chef_handler_sns']['version']</code></td>
  </tr>
</table>

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
depends "chef_handler_sns"
```

```ruby
# in your recipe
node["chef_handler_sns"]["topic_arn"] = "arn:aws:sns:us-east-1:12341234:MyTopicName"
include_recipe "chef_handler_sns::default"
```

### Using the LWRP from a Cookbook Recipe

You can also use the `chef_handler_sns` LWRP directly instead of including the recipe:

```ruby
# metadata.rb
depends "chef_handler_sns"
```

```ruby
# in your recipe
chef_handler_sns "arn:aws:sns:us-east-1:12341234:MyTopicName"
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
depends "chef_handler_sns"
```

```ruby
# in your recipe
chef_handler_sns "arn:aws:sns:us-east-1:12341234:MyTopicName" do
  access_key "***AMAZON-KEY***"
  secret_key "***AMAZON-SECRET***"
end
```

Contributing
============

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Author
=====================

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


