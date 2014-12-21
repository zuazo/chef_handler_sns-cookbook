Testing
=======

## Required Gems

* `yard`
* `vagrant`
* `foodcritic`
* `rubocop`
* `berkshelf`
* `should_not`
* `chefspec`
* `test-kitchen`
* `vagrant-wrapper`
* `kitchen-vagrant`

### Required Gems for Guard

* `guard`
* `guard-foodcritic`
* `guard-rubocop`
* `guard-rspec`
* `guard-kitchen`

More info at [Guard Readme](https://github.com/guard/guard#readme).

## Installing the Requirements

You must have [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) installed.

You can install gem dependencies with bundler:

    $ gem install bundler
    $ bundle install --without travis

## Generating the Documentation

    $ bundle exec rake doc

## Running the Syntax Style Tests

    $ bundle exec rake style

## Running the Unit Tests

    $ bundle exec rake unit

## Running the Integration Tests

    $ bundle exec rake integration

Or:

    $ bundle exec kitchen list
    $ bundle exec kitchen test
    [...]

## ChefSpec matchers

### chef_handler_sns(topic_arn)

Helper method for locating a `chef_handler_sns` resource in the collection.

```ruby
topic_arn = 'arn:aws:sns:us-east-1:12341234:MyTopicName'
resource = chef_run.chef_handler_sns(topic_arn)
expect(resource).to notify('service[apache2]').to(:reload)
```

### enable_chef_handler_sns(topic_arn)

Assert that the Chef run enables chef_handler_sns.

```ruby
topic_arn = 'arn:aws:sns:us-east-1:12341234:MyTopicName'
resource = chef_run.chef_handler_sns(topic_arn)
expect(resource).to enable_chef_handler_sns(topic_arn).with(
  :topic_arn => topic_arn
)
```
