# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
#  config.vm.box = "precise32"
  config.vm.box = "saucy"
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.network :forwarded_port, guest: 80, host: 10080
  config.vm.network :forwarded_port, guest: 443, host: 10443
  config.vm.network :forwarded_port, guest: 9200, host: 19200
  config.vm.network :public_network, bridge: "wlan0"
  config.vm.synced_folder "../data", "/vagrant_data"
end

