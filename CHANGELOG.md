CHANGELOG for chef_handler_sns
==============================
This file is used to list changes made in each version of the chef_handler_sns cookbook.

v1.0.0 (2014-06-07)
-------------------
- README: some style and small fixes.
- Fix support for Chef inside Bundler, used by [AWS OpsWorks](http://aws.amazon.com/opsworks/) (thanks [Michael Hobbs](https://github.com/michaelshobbs), for [reporting in chef-handler-sns issue #4](https://github.com/onddo/chef-handler-sns/issues/4)).
- Removed `use_system_libraries` attribute, [integrated inside xml cookbook](https://github.com/opscode-cookbooks/xml#attributes) ([1.2.4](https://github.com/opscode-cookbooks/xml/blob/master/CHANGELOG.md#v124-2014-03-27)).

v0.1.0 (2014-02-20)
-------------------
- Initial release of `chef_handler_sns`.
