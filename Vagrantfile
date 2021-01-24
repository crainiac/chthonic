# -*- mode: ruby -*-
# vi: set ft=ruby :

# Development environment for a Python package with Jupyter.
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
  config.vm.hostname = "chthonic"

  # Set up port forwarding to work with Jupyter.
  config.vm.network "forwarded_port", guest: 8888, host: 8888

  # Apply some VirtualBox-specific configurations.
  config.vm.provider "virtualbox" do |vb|
    # Make shared folders work, even on Windows.
    vb.customize ["setextradata", :id,
        "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vb.memory = "12288"
    vb.cpus = "4"
  end

  # Copy any local .vimrc file so that the VI editor will look right.
  if File.exists?(File.expand_path("~/.vimrc"))
    config.vm.provision "file", source: "~/.vimrc", destination: "~/.vimrc"
  end

  # Enable provisioning with a shell script.
  config.vm.provision "shell", inline: <<-SHELL

    # As a guideline, each extra-line-separated block
    # in this shell script is designed not to depend
    # on the execution order of the other blocks.

    # Install system requirements for Python.
    apt-get update
    apt-get install -y python3 python3-pip python3-venv
    apt-get -y autoremove
    # Install the package requirements and the package itself in a venv.
    cd /vagrant
    python3 -m venv .chthonic
    source .chthonic/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
    pip install -e .
    deactivate
    cd /home/vagrant
    # Activate the venv upon shell session startup.
    echo 'source /vagrant/.chthonic/bin/activate' >> /home/vagrant/.bashrc

    # Increase the swap size.
    swapoff -a
    dd if=/dev/zero of=/swapfile bs=1G count=8
    chmod 0600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    # Persist the new swap size.
    sed -i '$d' /etc/fstab
    echo '/swapfile  swap  swap  defaults  0 0' >> /etc/fstab

    # Go to the project folder upon shell session startup.
    echo 'cd /vagrant' >> /home/vagrant/.bashrc

    # Install Byobu for splitscreen editing.
    apt-get update
    apt-get install byobu
    apt-get -y autoremove

    # Install dos2unix to fix existing DOS-style newlines.
    apt-get update
    apt-get install dos2unix
    apt-get -y autoremove

    # Set fileformat to Unix in .vimrc to avoid DOS-style newlines.
    echo 'set ff=unix' >> /home/vagrant/.vimrc

  SHELL
end
