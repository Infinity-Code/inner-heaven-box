# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.vm.box = "puppetlabs/ubuntu-12.04-64-puppet"
  config.vm.box = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :machine
    config.cache.auto_detect = true
  end

  config.vm.provider "virtualbox" do |vb|
       vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path    = 'puppet/modules'
    puppet.manifest_file  = "main.pp"
    puppet.hiera_config_path = "puppet/hiera.yaml"
  end
end
