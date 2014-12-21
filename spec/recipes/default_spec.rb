# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL. (www.onddo.com)
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

require_relative '../spec_helper'

describe 'chef_handler_sns::default' do
  let(:topic_arn) { 'arn:aws:sns:us-east-1:12341234:MyTopicName' }
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['chef_handler_sns']['topic_arn'] = topic_arn
    end.converge(described_recipe)
  end

  it 'creates chef_handler_sns resource' do
    expect(chef_run).to enable_chef_handler_sns(topic_arn).with(
      topic_arn: topic_arn
    )
  end
end
