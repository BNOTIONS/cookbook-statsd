#
# Cookbook Name:: statsd
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'build-essential::default'
include_recipe 'git::default'
include_recipe 'nodejs::default'

group node['statsd']['group'] do
  action :create
end

user node['statsd']['user'] do
  group  node['statsd']['group']
  shell  '/bin/false'
  system true
  action :create
end

directory node['statsd']['config_path'] do
  owner     'root'
  group     'root'
  recursive true
  action    :create
end

git node['statsd']['install_path'] do
  repository node['statsd']['repository']
  revision   node['statsd']['revision']
  action     :sync
end

execute 'npm install' do
  cwd    node['statsd']['install_path']
  action :run
end

template '/etc/init/statsd.conf' do
  source    'upstart.conf.erb'
  mode      00644
  variables ({
    user:         node['statsd']['user'],
    config_path:  node['statsd']['config_path'],
    install_path: node['statsd']['install_path']
  })
  action   :create
end

service 'statsd' do
  provider        Chef::Provider::Service::Upstart
  stop_command    'stop statsd'
  start_command   'start statsd'
  restart_command 'stop statsd; start statsd'
  supports        :restart => true, :start => true, :stop => true
  action          :enable
end

unless node['statsd']['graphite_role'].nil?
  graphite_server = search(:node, node['statsd']['graphite_search_query']) % { graphite_role: node['statsd']['graphite_role'], chef_environment: node.chef_environment }
  node.default['statsd']['graphite_host'] = graphite_server.first['ipaddress']
end

template ::File.join(node['statsd']['config_path'], 'config.js') do
  source    'config.js.erb'
  mode      00644
  variables ({
    config: {
      port:           node['statsd']['port'],
      flushInterval:  node['statsd']['flush_interval'],
      backends:       node['statsd']['backends'],
      graphiteHost:   node['statsd']['graphite_host'],
      graphitePort:   node['statsd']['graphite_port']
    }
  })
  notifies :restart, 'service[statsd]', :delayed
  action   :create
end

service 'statsd' do
  action [:enable, :start]
end
