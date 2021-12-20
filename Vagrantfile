# frozen_string_literal: true
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.define :main do |main|
    main.vm.box = "generic/ubuntu2004"
    main.vm.provider :libvirt do |domain|
      domain.memory = 2048
      domain.cpus = 2
    end
    main.vm.network :private_network, :ip => '10.10.30.40'
    main.vm.hostname = "controlplane"
    main.vm.provision "shell", path: "setup_nodes.sh"
 end
  config.vm.define :node do |node|
    node.vm.box = "generic/ubuntu2004"
    node.vm.provider :libvirt do |domain|
      domain.memory = 4096
      domain.cpus = 2
    end

    node.vm.network :private_network, :ip => '10.10.30.41'
    node.vm.hostname = "node"
    node.vm.provision "shell", path: "setup_nodes.sh"
 end

  config.vm.define :lb do |lb|
    lb.vm.box = "generic/ubuntu2004"
    lb.vm.provider :libvirt do |domain|
      domain.memory = 2048
      domain.cpus = 1
    end

    lb.vm.network :private_network, :ip => '10.10.30.42'
    lb.vm.hostname = "lb"
    lb.vm.provision "shell" do |shell|
	    shell.path = "setup_loadbalancer.sh" 
	    shell.args  = ["10.10.30.41"]

     end
 end
end

