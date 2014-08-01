#
# Cookbook Name:: statsd
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'build-essential'
include_recipe 'git'
include_recipe 'node'

user 'statsd' do
  system true
  shell '/bin/false'
end

directory node[:statsd][:config_path] do
  recursive true
end

git node[:statsd][:path] do
  repository node[:statsd][:repository]
  revision node[:statsd][:revision]
  action :sync
end

execute 'npm install' do
  cwd node[:statsd][:path]
end

if platform?('ubuntu')
  template '/etc/init/statsd.conf' do
    source 'upstart.conf.erb'
    mode 00644
  end

  service 'statsd' do
    provider Chef::Provider::Service::Upstart
    stop_command 'stop statsd'
    start_command 'start statsd'
    restart_command 'stop statsd; start statsd'
    supports :restart => true, :start => true, :stop => true
  end
end

unless node[:statsd][:graphite_server_role].nil?
  graphite_server = search(:node, "role:#{node[:statsd][:graphite_server_role]} AND chef_environment:#{node[:statsd][:graphite_server_environment]}")
  node.default[:statsd][:graphite_host] = graphite_server.first[:ipaddress]
end

template "#{node[:statsd][:config_path]}/config.js" do
  source 'config.js.erb'
  mode 00644
  variables ({
    config: {
      port:           node[:statsd][:port],
      flushInterval:  node[:statsd][:flush_interval],
      backends:       node[:statsd][:backends],
      graphiteHost:   node[:statsd][:graphite_host],
      graphitePort:   node[:statsd][:graphite_port]
    }
  })
  notifies :restart, 'service[statsd]', :delayed
end

service 'statsd' do
  action [:enable, :start]
end
