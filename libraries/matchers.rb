# encoding: UTF-8
#
# Cookbook Name:: chef_handler_sns
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Library:: matchers
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

if defined?(ChefSpec)
  if ChefSpec.respond_to?(:define_matcher)
    # ChefSpec >= 4.1
    ChefSpec.define_matcher :chef_handler_sns
  elsif defined?(ChefSpec::Runner) &&
        ChefSpec::Runner.respond_to?(:define_runner_method)
    # ChefSpec < 4.1
    ChefSpec::Runner.define_runner_method :chef_handler_sns
  end

  #
  # Assert that a `chef_handler_sns` resource exists in the Chef run with the
  # action `:enable`. Given a Chef Recipe that installs `chef-handler-sns` gem:
  #
  # ```ruby
  # chef_handler_sns 'arn:aws:sns:us-east-1:1234:MyTopicName' do
  #   access_key '***AMAZON-KEY***'
  #   secret_key '***AMAZON-SECRET***'
  #   action :enable
  # end
  #
  # The Examples section demonstrates the different ways to test a
  # `chef_handler_sns` resource with ChefSpec.
  #
  # @example Assert that a `chef_handler_sns` was installed
  #   expect(chef_run)
  #     .to enable_chef_handler_sns('arn:aws:sns:us-east-1:1234:MyTopicName')
  #
  # @param topic_arn [String, Regex] The name of the resource to match.
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def enable_chef_handler_sns(topic_arn)
    ChefSpec::Matchers::ResourceMatcher.new(
      :chef_handler_sns, :enable, topic_arn
    )
  end
end
