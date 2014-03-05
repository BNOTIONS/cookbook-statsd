# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "statsd-berkshelf"

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      build_essential: {
        compiletime: true
      },
      node: {
        revision: "v0.10.24"
      }
    }

    chef.run_list = [
        "recipe[statsd::default]"
    ]
  end
end
