if defined?(ChefSpec)
  if ChefSpec.respond_to?(:define_matcher)
    # ChefSpec >= 4.1
    ChefSpec.define_matcher :chef_handler_sns
  elsif defined?(ChefSpec::Runner) &&
        ChefSpec::Runner.respond_to?(:define_runner_method)
    # ChefSpec < 4.1
    ChefSpec::Runner.define_runner_method :chef_handler_sns
  end

  def enable_chef_handler_sns(topic_arn)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_handler_sns, :enable, topic_arn)
  end
end
