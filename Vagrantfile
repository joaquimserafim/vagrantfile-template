# -*- mode: ruby -*-
# vi: set ft=ruby :

########## the external vars that we can use from shell ##########
# ENV['BOX']              : the box to be used
# ENV['BOX_NAME']         : the box name
# ENV['HOSTNAME']         : set the hostname
# ENV['IP']               : set the IP address
# ENV['SKIP_UPDATE']      : to skip the OS update
# ENV['SCRIPTS']          : use local scripts for the provision
# ENV['PROVISION']        : to choose the provision
# ENV['PROVISION_SCRIPT'] : to choose the provision script
##################################################################

#
# globals
#

$provision = "https://raw.githubusercontent.com/joaquimserafim/" +
  "vagrant-provision/master/provision.sh"
$box = ENV['BOX'] || "https://cloud-images.ubuntu.com/vagrant/trusty/current/" +
  "trusty-server-cloudimg-amd64-vagrant-disk1.box"
$VAGRANTFILE_API_VERSION = "2"

#
# we need some plugins
#

def checkPlugin(name)
  if !Vagrant.has_plugin?(name)
    puts "'#{name}' plugin is required, installing it..."
    install = `vagrant plugin install #{name}`
  end
end

#
# Vagrant config
#

Vagrant.configure($VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = ENV['BOX_NAME'] || "ubuntu-server-trusty"
  config.vm.box_url = $box
  config.vm.hostname = ENV['HOSTNAME'] || "vm"

  #config.vm.network :forwarded_port, guest: 3000, host: 3000, auto_correct: true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: (ENV['IP'] || "192.168.33.10")

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "~", "/vagrant"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
    vb.name = "vagrant-template_" + SecureRandom.uuid
    vb.customize [
      "modifyvm", :id,
      "--memory", "512"
    ]
  end

  if $*[0] == "up"
    puts "==> verifying plugins..."
    checkPlugin("vagrant-reload")
  end

  # The shell to use when executing SSH commands from Vagrant
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # update the OS
  if !ENV['SKIP_UPDATE']
    config.vm.provision "shell",
      path: ENV['PROVISION_SCRIPT'] || $provision,
      args: "null update_os"
    config.vm.provision :reload
  end

  # use local scripts for the provision
  if ENV['SCRIPTS']
    config.vm.synced_folder ENV['SCRIPTS'], "/home/vagrant/.scripts"
    ENV['SCRIPTS'] = "/home/vagrant/.scripts"
  end

  # PROVISION
  ENV['PROVISION'] = "htop git " + (ENV['PROVISION'] || "")

  config.vm.provision "shell",
    path: ENV['PROVISION_SCRIPT'] || $provision,
    args: "#{ENV['SCRIPTS'] || false} #{ENV['PROVISION']}"
end
