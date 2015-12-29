# encoding: UTF-8
#
# Cookbook Name:: chef_handler_sns
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Provider:: default
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

require 'chef/application'

def topic_arn
  new_resource.topic_arn
end

def access_key
  new_resource.access_key(
    if new_resource.access_key.nil?
      node['chef_handler_sns']['access_key']
    else
      new_resource.access_key
    end
  )
end

def secret_key_attribute
  node['chef_handler_sns']['secret_key']
end

def secret_key_attribute_warn
  Chef::Log.warn(
    'You should not use the node["chef_handler_sns"]["secret_key"] '\
    'attribute. It is best to use the "chef_handler_sns" resource and pass '\
    'it as argument.'
  )
end

def secret_key
  if new_resource.secret_key.nil? && !secret_key_attribute.nil?
    secret_key_attribute_warn
    new_resource.secret_key(secret_key_attribute)
  else
    new_resource.secret_key
  end
end

def token
  new_resource.token(
    if new_resource.token.nil?
      node['chef_handler_sns']['token']
    else
      new_resource.token
    end
  )
end

def region
  new_resource.region(
    if new_resource.region.nil?
      node['chef_handler_sns']['region']
    else
      new_resource.region
    end
  )
end

def subject
  new_resource.subject(
    if new_resource.subject.nil?
      node['chef_handler_sns']['subject']
    else
      new_resource.subject
    end
  )
end

def body_template
  new_resource.body_template(
    if new_resource.body_template.nil?
      node['chef_handler_sns']['body_template']
    else
      new_resource.body_template
    end
  )
end

def chef_handler_supports
  new_resource.supports(
    if new_resource.supports.nil? || new_resource.supports.empty?
      node['chef_handler_sns']['supports'].to_hash
    else
      new_resource.supports
    end
  )
end

def gem_version
  new_resource.version(
    if new_resource.version.nil?
      node['chef_handler_sns']['version']
    else
      new_resource.version
    end
  )
end

def gem_mirror_url
  new_resource.mirror_url(
    if new_resource.mirror_url.nil?
      node['chef_handler_sns']['mirror_url']
    else
      new_resource.mirror_url
    end
  )
end

def gem_prerelease
  gem_version.is_a?(String) && gem_version.match(/^[0-9.]+$/) != true
end

def gem_options
  gem_prerelease ? '--prerelease' : nil
end

def whyrun_supported?
  true
end

action :enable do
  # Set `chef-handler-sns` gem arguments
  argument_array = {
    topic_arn: topic_arn
  }
  argument_array[:access_key] = access_key unless access_key.nil?
  argument_array[:secret_key] = secret_key unless secret_key.nil?
  argument_array[:token] = token unless token.nil?
  argument_array[:region] = region unless region.nil?
  argument_array[:subject] = subject unless subject.nil?
  argument_array[:body_template] = body_template unless body_template.nil?

  # Use older version of the cookbook for versions that require nokogiri:
  if gem_version.is_a?(String) && gem_version.split('.', 2)[0].to_i < 2
    fail <<-EOE

chef_handler_sns cookbook version `3` only supports chef-handler-sns `>= 2`.

If you need to use older versions of chef-handler-sns gem, you have to use
older cookbook versions. For example:

# Berksfile
cookbook 'chef_handler_sns', '~> 2.0'

    EOE
  end

  # Install the `chef-handler-sns` RubyGem during the compile phase
  if gem_mirror_url.is_a?(String) && gem_version.is_a?(String)
    chef_handler_sns_file = "chef-handler-sns-#{gem_version}.gem"
    file_path = ::File.join(
      Chef::Config[:file_cache_path],
      chef_handler_sns_file
    )
    file_url = "#{gem_mirror_url}/#{chef_handler_sns_file}"

    remote_file file_path do
      source file_url
    end.run_action(:create)

    gem_package 'chef-handler-sns' do
      source file_path
      options gem_options
    end.run_action(:install)
  elsif defined?(OpsWorks::InternalGems)
    OpsWorks::InternalGems.internal_gem_package('chef-handler-sns')
  elsif defined?(Chef::Resource::ChefGem)
    chef_gem 'chef-handler-sns' do
      version gem_version
      options gem_options
      if Chef::Resource::ChefGem.method_defined?(:compile_time)
        compile_time true
      end
    end
  else
    gem_package('chef-handler-sns') do
      version gem_version
      options gem_options
      action :nothing
    end.run_action(:install)
  end

  # Get the installed `chef-handler-sns` gem path
  sns_handler_path = nil
  if defined?(Bundler) && ENV.key?('BUNDLE_BIN_PATH') && !defined?(ChefSpec)
    # Gem::Specification#each_spec would be better, but requires >= 1.9.2
    bundle_path = ::File.join(Bundler.bundle_path.to_s, 'specifications')
    Dir[::File.join(bundle_path, '*.gemspec')].each do |path|
      spec = Gem::Specification.load(path.untaint)
      sns_handler_path = spec.lib_dirs_glob if spec.name == 'chef-handler-sns'
    end
    if sns_handler_path.nil?
      Chef::Application.fatal!(
        "chef-handler-sns not found inside Bundler path: #{bundle_path}"
      )
    end
  elsif Gem::Specification.respond_to?('find_by_name')
    gem_spec = Gem::Specification.find_by_name('chef-handler-sns')
    sns_handler_path = gem_spec.lib_dirs_glob unless gem_spec.nil?
  else
    sns_handler_path = Gem.all_load_paths.grep(/chef-handler-sns/).first
  end

  converge_by("Install #{new_resource}") do
    # Then activate the handler with the `chef_handler` LWRP
    chef_handler 'Chef::Handler::Sns' do
      if sns_handler_path.nil?
        source 'chef/handler/sns'
      else
        source "#{sns_handler_path}/chef/handler/sns"
      end
      arguments argument_array
      supports chef_handler_supports
      action :enable
    end
  end
end
