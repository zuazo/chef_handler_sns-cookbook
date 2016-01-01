# CHANGELOG for chef_handler_sns

This file is used to list changes made in each version of the `chef_handler_sns` cookbook.

## v3.0.0 (2016-01-01)

### Breaking Changes on v3.0.0

* Update `chef-handler-sns` gem to version 2.
 * Drop gem version `1` support.

### Improvements on v3.0.0

* Update RuboCop to `0.35`.
* metadata: Add `source_url` and `issues_url` links.
* Add version constraint to `chef_handler` dependency.

### Documentation Changes on v3.0.0

* Some documentation improvements.
* Add a LICENSE file.
* Add a .yardopts and a .inch.yml file.
* Update license year.
* README:
 * Fix the json example.
 * Move ChefSpec matchers to the README.
 * Add badges: GitHub, license, gemnasium.

### Changes on Tests on v3.0.0

* Run test-kitchen with Travis CI native Docker support.
* Test on multiple platforms, including using Docker and multiple clouds.
* Move ChefSpec tests to test/unit.

## v2.0.0 (2015-12-26)

### Breaking Changes on v2.0.0

* Drop Ruby `1.8` and `1.9.2` support (not tested).

### New Features on v2.0.0

* ChefSpec matchers: Add helper methods to locate LWRP resources.
* Add support to install from a URL.

### Fixes on v2.0.0

* Fix prerelease gem option.
* Use relative gem path if complete path is not found.

### Improvements on v2.0.0

* Integrate with RuboCop.
* Enable `chef_gem#compile_time` for Chef `12`.
* Install `chef-handler-sns` gem version `1.2.0` by default.

### Documentation Changes on v2.0.0

* Homogenize license headers.
* Update chef links to use *chef.io* domain.
* Update contact information and links after migration.
* README:
 * Fix build status badge links.
 * Split it in multiple files.

### Changes on Tests on v2.0.0

* Gemfile: Upadte to ChefSpec `4.1`.
* Fix RSpec old syntax warnings.
* Integrate with `should_not`
* Updates: Berksfile, Gemfile, Guardfile, Rakefile.
* Enable ChefSpec coverage.
* Update Berkshelf to version `4`.
* Run tests on Ruby `2.2`.
* Update foodcritic to version `5`.

## v1.1.0 (2014-07-07)

* README:
 * Clarify setting for both reports ([issue #1](https://github.com/zuazo/chef_handler_sns-cookbook/pull/2), thanks [Florian Holzhauer](https://github.com/fh)).
* Token attribute should accept `false` (related to [`chef-handler-sns` gem issue #5](https://github.com/zuazo/chef-handler-sns/issues/5), thanks [Michael Hobbs](https://github.com/michaelshobbs) for reporting and testing).
* Gemfile:
 * Some versions updated.
 * Added `chef-sugar` as dependency for the tests.


## v1.0.0 (2014-06-07)

* README: some style and small fixes.
* Fix support for Chef inside Bundler, used by [AWS OpsWorks](http://aws.amazon.com/opsworks/) (thanks [Michael Hobbs](https://github.com/michaelshobbs), for [reporting in chef-handler-sns issue #4](https://github.com/zuazo/chef-handler-sns/issues/4)).
* Removed `use_system_libraries` attribute, [integrated inside xml cookbook](https://github.com/opscode-cookbooks/xml#attributes) ([1.2.4](https://github.com/opscode-cookbooks/xml/blob/master/CHANGELOG.md#v124-2014-03-27)).

## v0.1.0 (2014-02-20)

* Initial release of `chef_handler_sns`.
