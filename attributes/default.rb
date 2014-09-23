
default['statsd']['user']             = 'statsd'
default['statsd']['group']            = 'statsd'

default['statsd']['install_path']     = '/opt/statsd'
default['statsd']['config_path']      = '/etc/statsd'

default['statsd']['repository']       = 'https://github.com/etsy/statsd.git'
default['statsd']['revision']         = 'v0.7.2'

default['statsd']['flush_interval']   = 1000
default['statsd']['port']             = 8125

default['statsd']['backends']         = ['./backends/graphite']

default['statsd']['graphite_host']    = 'localhost'
default['statsd']['graphite_port']    = 2003
default['statsd']['graphite_role']    = nil

default['statsd']['graphite_search_query'] = 'role:%{graphite_role} AND chef_environment:%{chef_environment}'
