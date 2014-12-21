# encoding: UTF-8

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
