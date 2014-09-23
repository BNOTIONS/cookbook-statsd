require 'spec_helper'

describe 'statsd::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      # set node attributes
      node.automatic['platform_family'] = 'debian'
      node.automatic['lsb']['codename'] = 'precise'

      node.set['build-essential']['compile_time'] = true

      node.set['statsd'] = {
        user:           'statsd',
        group:          'statsd',
        install_path:   '/opt/statsd',
        config_path:    '/etc/statsd',
        repository:     'https://github.com/etsy/statsd.git',
        revision:       'v0.7.2',
        flush_interval: 1000,
        port:           8125,
        backends:       ['./backends/graphite'],
        graphite_host:  '127.0.0.1',
        graphite_post:  '2003'
      }
    end.converge(described_recipe)
  end

#  before do
#    # stubs for resources (commands, data bags, etc)
#  end

  it 'includes `build-essential::default` recipe' do
    expect(chef_run).to include_recipe('build-essential::default')
  end

  it 'includes `git::default` recipe' do
    expect(chef_run).to include_recipe('git::default')
  end

  it 'includes `nodejs::default` recipe' do
    expect(chef_run).to include_recipe('nodejs::default')
  end

  it 'creates `statsd` group' do
    expect(chef_run).to create_group('statsd')
  end

  it 'creates `statsd` user' do
    expect(chef_run).to create_user('statsd')
  end

  it 'creates `/etc/statsd` directory' do
    expect(chef_run).to create_directory('/etc/statsd')
  end

  it 'syncs `/opt/statsd` git' do
    expect(chef_run).to sync_git('/opt/statsd')
  end

  it 'runs `npm install` execute' do
    expect(chef_run).to run_execute('npm install')
  end

  it 'creates `/etc/init/statsd.conf` template' do
    expect(chef_run).to create_template('/etc/init/statsd.conf')
  end

  it 'enables `statsd` service' do
    expect(chef_run).to enable_service('statsd')
  end

  it 'creates `/etc/statsd/config.js` template' do
    expect(chef_run).to create_template('/etc/statsd/config.js')
  end

#  it 'includes the `apt::default` recipe' do
#    expect(chef_run).to include_recipe('apt::default')
#  end
end
