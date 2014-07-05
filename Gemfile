# -*- mode: ruby -*-
# vi: set ft=ruby :

source 'https://rubygems.org'

group :test, :development do
  gem 'rake'
end

group :test do
  gem 'chef-sugar' # required by xml[1.2.6]->chef-sugar cookbook
  gem 'berkshelf', '~> 2.0'
  gem 'chefspec', '~> 4.0'
  gem 'foodcritic', '~> 3.0'
end

group :integration do
  gem 'test-kitchen', '~> 1.2'
  gem 'kitchen-vagrant', '~> 0.15'
end
