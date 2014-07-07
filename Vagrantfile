VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # CentOS 6.5 for VirtualBox
  config.vm.provider :virtualbox do |virtualbox, override|
    override.vm.box     = 'puppetlabs-centos-65-x64-vbox'
    override.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box'
    virtualbox.memory   = 512
    virtualbox.customize ["modifyvm", :id, "--cpus", "1"]
  end

  # VM Settings for reverse proxy, I call it devopsproxy
  config.vm.define :devopsproxy do |devopsproxy|
    devopsproxy.vm.hostname = 'devopsproxy.rds.priv'
    # this IP is Vagrant specific and doesn't need to match your production environment
    devopsproxy.vm.network "private_network", ip: "192.168.56.10"
    
    # Install git & r10k, followed by all the required puppet modules defined in Puppetfile
    devopsproxy.vm.provision "shell", inline: 'rpm -q git &> /dev/null || yum install -q -y git'
    devopsproxy.vm.provision "shell", inline: 'gem query --name r10k --installed &> /dev/null || gem install --no-rdoc --no-ri r10k -v 1.2.0rc2'
    devopsproxy.vm.provision "shell", inline: 'cd /vagrant && r10k -v info puppetfile install'
    # Production environment should have DNS configured for private network, in Vagrant, we need to hardcode it
    devopsproxy.vm.provision "shell", inline: 'echo \'192.168.56.10 devopsproxy.rds.priv\' >> /etc/hosts'
    devopsproxy.vm.provision "shell", inline: 'echo \'192.168.56.20 sonar.rds.priv\' >> /etc/hosts'
    
    # Configure the puppet provisioner
    devopsproxy.vm.provision "puppet" do |puppet|
      puppet.manifest_file     = "site.pp"
      puppet.module_path       = ["site", "dist", "modules"]
   #  if you know what hiera is, feel free to uncomment and use it
   #  puppet.hiera_config_path = "hieradata/hiera.yaml"
      puppet.options       = "--verbose"
    end
 
  end
  
  # VM Settings for sonar server
  config.vm.define :sonar do |sonar|
    sonar.vm.hostname = 'sonar.rds.priv'
    sonar.vm.network "private_network", ip: "192.168.56.20"
    
    # Install git & r10k, followed by all the required puppet modules defined in Puppetfile
    sonar.vm.provision "shell", inline: 'rpm -q git &> /dev/null || yum install -q -y git'
    sonar.vm.provision "shell", inline: 'gem query --name r10k --installed &> /dev/null || gem install --no-rdoc --no-ri r10k -v 1.2.0rc2'
    sonar.vm.provision "shell", inline: 'cd /vagrant && r10k -v info puppetfile install'
    # Production environment should have DNS configured for private network, in Vagrant, we need to hardcode it
    sonar.vm.provision "shell", inline: 'echo \'192.168.56.10 devopsproxy.rds.priv\' >> /etc/hosts'
    sonar.vm.provision "shell", inline: 'echo \'192.168.56.20 sonar.rds.priv\' >> /etc/hosts'

    # Configure the puppet provisioner
    sonar.vm.provision "puppet" do |puppet|
      puppet.manifest_file     = "site.pp"
      puppet.module_path       = ["site", "dist", "modules"]
    #  if you know what hiera is, feel free to uncomment and use it
    # puppet.hiera_config_path = "hieradata/hiera.yaml"
      puppet.options       = "--verbose"
    end
  end

end