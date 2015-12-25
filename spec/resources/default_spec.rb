require_relative '../spec_helper'

describe 'chef_handler_sns resource' do
  let(:topic_arn) { 'arn:aws:sns:us-east-1:12341234:MyTopicName' }
  let(:chef_handler_sns_path) { '/tmp/chef-handler-sns' }
  let(:file_cache_path) { '/var/chef/cache' }
  let(:chef_runner) do
    ChefSpec::Runner.new(
      platform: 'ubuntu', version: '12.04', step_into: ['chef_handler_sns'],
      file_cache_path: file_cache_path
    )
  end
  let(:chef_run) { chef_runner.converge('chef_handler_sns::default') }
  let(:node) { chef_runner.node }
  before do
    node.set['chef_handler_sns']['topic_arn'] = topic_arn
    gemspec = Gem::Specification.new
    gemspec.name = 'chef-handler-sns'
    gemspec.stub(:lib_dirs_glob).and_return(chef_handler_sns_path)
    Gem::Specification.stub(:find_by_name).with('chef-handler-sns').and_return(gemspec)
  end

  it 'should include xml::ruby recipe' do
    expect(chef_run).to include_recipe('xml::ruby')
  end

  it 'should install chef-handler-sns gem' do
    expect(chef_run).to install_chef_gem('chef-handler-sns')
  end

  it 'should run chef_handler resource' do
    expect(chef_run).to enable_chef_handler('Chef::Handler::Sns').with(
      :source => "#{chef_handler_sns_path}/chef/handler/sns",
      :supports => Mash.new({
        :exception => true,
        :report => false
      })
    )
  end

  context 'with mirror url' do
    let(:mirror_url) { 'https://mirror.gems.com' }
    let(:version) { '2.0.0.dev' }
    let(:file_name) { ::File.join("chef-handler-sns-#{version}.gem") }
    let(:file_path) { ::File.join(file_cache_path, file_name) }
    let(:file_url) { "#{mirror_url}/#{file_name}" }
    before do
      node.set['chef_handler_sns']['version'] = version
      node.set['chef_handler_sns']['mirror_url'] = mirror_url
    end

    it 'downloads remote gem' do
      expect(chef_run).to create_remote_file(file_path)
        .with_source(file_url)
    end

    it 'installs the gem' do
      expect(chef_run).to install_gem_package('chef-handler-sns')
        .with_source(file_path)
        .with_options('--prerelease')
    end
  end
end
