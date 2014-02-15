if defined?(ChefSpec)
  def install_chef_handler_sns(topic_arn)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_handler_sns, :install, topic_arn)
  end
end
