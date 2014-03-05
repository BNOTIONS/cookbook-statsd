# statsd cookbook

# Platforms

Currently only supports ubuntu, should be trivial to add support for other linux distros.

# Requirements

* `build-essential`
* `git`
* `node`

# Usage

Add `recipe[statsd]` to your runlist.

# Attributes

* `node[:statsd][:path]` - Installation path
* `node[:statsd][:user]` - User to run statsd daemon
* `node[:statsd][:config_path]` - Path to statsd configuration files
* `node[:statsd][:repository]` - Repository to statsd source
* `node[:statsd][:revision]` - Branch or tagged version of statsd to retrieve
* `node[:statsd][:flush_interval]` - Flush interval time in milliseconds
* `node[:statsd][:port]` - Port to listen on
* `node[:statsd][:backends]` - An array of backends to be included, defaults to graphite
* `node[:statsd][:graphite_host]` - Host or IP address of graphite server
* `node[:statsd][:graphite_port]` - Graphite port
* `node[:statsd][:graphite_server_role]` - Role to search for to autoconfigure graphite host variable

# Recipes

* `default` - Installs statsd

# Author

Author:: Jonathon W. Marshall (<jonathon@bnotions.com>)
