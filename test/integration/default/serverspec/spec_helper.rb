require 'serverspec'
require 'pathname'
require 'json'

begin
  require 'deep_merge'
rescue LoadError
  require 'rubygems/dependency_installer'
  Gem::DependencyInstaller.new.install('deep_merge')
  require 'deep_merge'
end

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
    c.path = '/sbin:/usr/sbin'
  end
end

# Pull in latest chef-handler json report
report_dir = '/var/chef/reports'
report_file = Dir.entries(report_dir).sort_by { |f| File.mtime(File.join(report_dir, f)) }.last
report = ::JSON.parse(File.read(File.join(report_dir, report_file)))

# Build node attributes
$node = JSON.parse('{}')
$node.merge!(report['node']['default']) unless report['node']['default'].empty?
$node.deep_merge!(report['node']['normal']) unless report['node']['normal'].empty?
