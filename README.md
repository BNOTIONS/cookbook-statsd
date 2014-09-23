statsd Cookbook
=============================
Installs statsd from git.

Requirements
------------

### Cookbooks

- `build-essential`
- `git`
- `nodejs`

### Platforms

- `ubuntu`


Attributes
----------
See `attributes/default.rb` for defaults.

- node['statsd']['user'] - User to run statsd daemon
- node['statsd']['group'] - Group to run statsd daemon
- node['statsd']['install_path'] - Path to install statsd
- node['statsd']['config_path'] - Path to statsd configuration files
- node['statsd']['repository'] - Repository to statsd source
- node['statsd']['revision'] - Branch or tagged version of statsd to retrieve
- node['statsd']['flush_interval'] - Flush interval time in milliseconds
- node['statsd']['port'] - Port to listen on
- node['statsd']['backends'] - An array of backends to be included, defaults to graphite
- node['statsd']['graphite_host'] - Host or IP address of graphite server
- node['statsd']['graphite_port'] - Graphite port
- node['statsd']['graphite_role'] - Role to search for to autoconfigure graphite host variable
- node['statsd']['graphite_search'] - Search query used to find graphite servers


Recipes
-------

- `default` - Install statsd


License & Authors
-----------------
Copyright:: 2014, BNOTIONS (<devops@bnotions.com>) - All rights reserved.

Unless otherwise indicated, all materials within are copyrighted by BNOTIONS. All rights reserved. No part of these pages, either text or image may be used for any purpose other than personal use. Therefore, reproduction, modification, storage in a retrieval system or retransmission, in any form or by any means, electronic, mechanical or otherwise, for reasons other than personal use, is strictly prohibited without prior written permission.

### Authors

- Jonathon W. Marshall



