# encoding: UTF-8
#
# Cookbook Name:: chef_handler_sns
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Resource:: default
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

actions :enable

attribute :topic_arn, kind_of: String, name_attribute: true
attribute :access_key, kind_of: String, default: nil
attribute :secret_key, kind_of: String, default: nil
attribute :token, kind_of: [String, FalseClass], default: nil
attribute :region, kind_of: String, default: nil
attribute :subject, kind_of: String, default: nil
attribute :body_template, kind_of: String, default: nil

attribute :supports, kind_of: Hash, default: nil
attribute :version, kind_of: String, default: nil
attribute :mirror_url, kind_of: String, default: nil

def initialize(*args)
  super
  @action = :enable
end
