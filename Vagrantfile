# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs-wheezy64"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box"

  # config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :private_network, ip: "192.168.33.200"
  # config.vm.network :public_network

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.module_path = "puppet/modules"
     puppet.manifest_file  = "init.pp"
     puppet.options="--verbose --debug"
     require 'rbconfig'
     if (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
         puppet.options << " --color=false"
     end
  end
end
