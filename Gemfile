# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

source 'https://rubygems.org'

group :test do
  gem 'rake'
  gem 'berkshelf', '~> 4.0'
end

group :style do
  gem 'foodcritic', '= 5.0.0'
  gem 'rubocop', '= 0.28.0'
end

group :unit do
  gem 'should_not', '~> 1.1'
  gem 'chefspec', '~> 4.1'
  gem 'chef-sugar' # required by xml[1.2.6]->chef-sugar cookbook
end

group :integration do
  gem 'vagrant-wrapper', '~> 2.0'
  gem 'test-kitchen', '~> 1.2'
  gem 'kitchen-vagrant', '~> 0.10'
end

group :guard do
  gem 'guard', '~> 2.6'
  gem 'guard-foodcritic', '~> 2.0'
  gem 'guard-rubocop', '~> 1.1'
  gem 'guard-rspec', '~> 4.3'
  # Temporary disabled: Error is: cannot load such file -- guard/kitchen
  # gem 'guard-kitchen', '~> 0.0.0'
end
