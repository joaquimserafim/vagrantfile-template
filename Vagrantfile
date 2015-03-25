# -*- mode: ruby -*-
# vi: set ft=ruby :

require './provision_reboot'

## globals
$provision = "https://raw.githubusercontent.com/joaquimserafim/" +
  "vagrant-provision/master/provision.sh"
$box = "https://cloud-images.ubuntu.com/vagrant/trusty/current/" +
  "trusty-server-cloudimg-amd64-vagrant-disk1.box"

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu-server-trusty"
  config.vm.box_url = $box

  #config.vm.network :forwarded_port, guest: 3000, host: 3000, auto_correct: true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.10"

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

  module OS
    def OS.windows?
      (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end
  end

  # The shell to use when executing SSH commands from Vagrant
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  #############
  # ENV['NOUPDATE'] : to skip the OS update
  # ENV['SCRIPTS']  : to choose if wants to use local scripts for the provision
  # ENV['PROVISION']: to choose the provision
  #############

  # update the OS
  if !ENV['NOUPDATE']
    config.vm.provision "shell", path: $provision, args: "null update_os"
    # need the 'provision_reboot' file for this
    # now we need to reboot in the middle of the provision
    if OS.windows?
      config.vm.provision :windows_reboot
    else
      config.vm.provision :unix_reboot
    end
  end

  # use local scripts for the provision
  if ENV['SCRIPTS']
    config.vm.synced_folder ENV['SCRIPTS'], "/home/vagrant/.scripts"
    ENV['SCRIPTS'] = "/home/vagrant/.scripts"
  end

  # PROVISION
  ENV['PROVISION'] = "htop git " + (ENV['PROVISION'] || "")

  config.vm.provision "shell",
    path: $provision,
    args: "#{ENV['SCRIPTS'] || false} #{ENV['PROVISION']}"
end