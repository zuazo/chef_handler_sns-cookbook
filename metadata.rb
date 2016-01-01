# encoding: UTF-8
#
# Cookbook Name:: chef_handler_sns
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name 'chef_handler_sns'
maintainer 'Xabier de Zuazo'
maintainer_email 'xabier@zuazo.org'
license 'Apache 2.0'
description <<-EOS
Installs and enables chef-handler-sns: A simple Chef report handler that reports
status of a Chef run through Amazon SNS. Includes IAM roles support. Amazon SNS
can send notifications by SMS, email, Amazon SQS queues or to any HTTP endpoint.
EOS
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '3.0.0'

if respond_to?(:source_url)
  source_url "https://github.com/zuazo/#{name}-cookbook"
end
if respond_to?(:issues_url)
  issues_url "https://github.com/zuazo/#{name}-cookbook/issues"
end

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'freebsd'
supports 'opensuse'
supports 'oracle'
supports 'redhat'
supports 'scientific'
supports 'suse'
supports 'ubuntu'

depends 'chef_handler', '~> 1.0'

recipe 'chef_handler_sns::default', 'Installs and loads the Chef SNS Handler.'

provides 'chef_handler_sns'

attribute 'chef_handler_sns/topic_arn',
          display_name: 'chef-handler-sns topic_arn',
          description: 'AWS topic ARN name (required).',
          type: 'string',
          required: 'required'

attribute 'chef_handler_sns/access_key',
          display_name: 'chef-handler-sns access_key',
          description:
            'AWS access key (required, but will try to read it from ohai with '\
            'IAM roles).',
          type: 'string',
          required: 'optional',
          calculated: true

attribute 'chef_handler_sns/secret_key',
          display_name: 'chef-handler-sns secret_key',
          description:
            'AWS secret key (required, but will try to read it from ohai with '\
            'IAM roles).',
          type: 'string',
          required: 'optional',
          calculated: true

attribute 'chef_handler_sns/token',
          display_name: 'chef-handler-sns token',
          description:
            'AWS security token (read from ohai with IAM roles). Set to false '\
            'to disable the token detected by ohai.',
          type: 'string',
          required: 'optional',
          calculated: true

attribute 'chef_handler_sns/region',
          display_name: 'chef-handler-sns region',
          description: 'AWS region.',
          type: 'string',
          required: 'optional',
          calculated: true

attribute 'chef_handler_sns/subject',
          display_name: 'chef-handler-sns subject',
          description: 'Message subject string in erubis format.',
          type: 'string',
          required: 'optional',
          calculated: true

attribute 'chef_handler_sns/body_template',
          display_name: 'chef-handler-sns body_template',
          description:
            'Full path of an erubis template file to use for the message body.',
          type: 'string',
          required: 'optional',
          calculated: true

attribute 'chef_handler_sns/supports',
          display_name: 'chef-handler supports',
          description:
            'Type of Chef Handler to register as, ie :report, :exception or '\
            'both.',
          type: 'hash',
          required: 'optional',
          default: '{ "exception" => true }'

attribute 'chef_handler_sns/version',
          display_name: 'chef-handler-sns version',
          description: 'chef-handler-sns gem version to install.',
          type: 'string',
          required: 'optional',
          calculated: true

attribute 'chef_handler_sns/mirror_url',
          display_name: 'chef-handler-sns mirror url',
          description:
            'chef-handler-sns mirror to download the gem from. For cases '\
            'where you do not want to use RubyGems.',
          type: 'string',
          required: 'optional',
          calculated: true
