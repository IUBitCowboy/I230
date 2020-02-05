# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  
  config.vm.define "I230-Lab2-fatima" do |config| 
    config.vm.provider :digital_ocean do |provider,override|
      config.vm.box = "digital_ocean"
      config.ssh.private_key_path = "./do_vagrant"
      config.ssh.username = "vagrant"
      # provider.client_id = "digital-ocean-seiffert-tkn1"
      provider.token = "b0e0d17aa298306fc8baaa8bbd7af140989ca79f864aba780e696e7351ba6ad8"
      override.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"
      # provider.image = "ubuntu 14.04.5 x64"
      provider.image = "ubuntu-14-04-x64"
      provider.region = "nyc1"
      config.vm.synced_folder ".", "/vagrant", disabled: true
    end
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    # add user vagrant
    # useradd vagrant -m -s /bin/bash
    # create ~vagrant/.ssh directory
    # mkdir ~vagrant/.ssh
    # copy authorization key to vagrant/.ssh
    # cp ~/.ssh/authorized_keys ~vagrant/.ssh
    # create /vagrant directory
    mkdir /vagrant
    # transfer lab files to /vagrant
    cd /vagrant
    wget -O Day_1-Introduction.pdf https://iu.instructure.com/files/76516342/download?download_frd=1 &> /dev/null
    chown -R vagrant:vagrant ~vagrant/.ssh /vagrant
    
  SHELL
end
