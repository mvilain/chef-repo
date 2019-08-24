# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Vagrantfile for chef-rep (creates workstation VM plus a bunch of clients)
# 201908.24MeV upgrade to latest chef workstation (DK depricated) and Infra client

Vagrant.configure("2") do |config|
	config.ssh.insert_key = false
	# config.vm.network 'forwarded_port', guest: 80, host: 8080
	config.vm.synced_folder '.', '/vagrant', disabled: false
	config.vm.provider :virtualbox do |vb|
		#vb.gui = true
		vb.memory = '1024'
	end
	# insert the following for working behind a proxy server
	# https won't work well, but http is fine
	if Vagrant.has_plugin?("vagrant-proxyconf")
		config.proxy.http     = "http://www-proxy.us.oracle.com:80"
		config.proxy.https    = "https://www-proxy.us.oracle.com:80"
		config.proxy.no_proxy = "localhost,127.0.0.1,.local"
	end

	#
	# PROVISION ON ALL MACHINES 
	# -- allow ssh w/o checking
	#
	config.vm.provision "shell", inline:  <<SHELLALL
		echo "...disabling ssh CheckHostIP..."
		sed -i.orig -e "s/#   CheckHostIP yes/CheckHostIP no/" /etc/ssh/ssh_config

# install older chef client on all nodes...it doesn't ask for license verification
# this will NOT run chef whereas the code below *will* install and run chef
		echo "installing chef client..."
		curl -L https://omnitruck.chef.io/install.sh >chef-install.sh 2>&1
		bash ./chef-install.sh -v 14.13.11 >chef-install.log 2>&1
		# cat chef-install.log

SHELLALL

# install older chef client which doesn't ask for license verification
# 	config.vm.provision "chef_zero" do |chef|
# 		chef.install = true
# 		chef.product = 'chef'
# 		chef.channel = 'current'
# 		chef.version = '14.13.11'
# 		chef.nodes_path = 'nodes'
# end

##-------------------------------------------------------------------------------
# configure a Chef Workstation (RHEL 6+7, SuSE 11+12, Ubuntu 16.04+18.04)
# https://docs.chef.io/platforms.html
# https://downloads.chef.io/chef-workstation/0.8.7
##-------------------------------------------------------------------------------

	config.vm.define "ws_c6" do |ws_c6|
		ws_c6.vm.box = "geerlingguy/centos6"
		ws_c6.vm.network 'private_network', ip: '192.168.10.106'
		ws_c6.vm.hostname = 'ws-c6'
		ws_c6.vm.provision "shell", inline: %q|
			# yum update -y >yum-update.log 2>&1
			echo "installing chefdk"
|
		ws_c6.vm.provision "chef_zero" do |chef|
			chef.node_name = 'ws-c6'
			chef.product = 'chefdk'
			chef.channel = 'current'
			chef.version = '4.3.13'
			chef.install = false
			chef.cookbooks_path = "cookbooks"
			chef.data_bags_path = "data_bags"
			chef.nodes_path = "nodes"
			chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

	config.vm.define "ws_c7" do |ws_c7|
		ws_c7.vm.box = "geerlingguy/centos7"
		ws_c7.vm.network 'private_network', ip: '192.168.10.107'
		ws_c7.vm.hostname = 'ws-c7'
		ws_c7.vm.provision "shell", inline: %q|
			# yum update -y >yum-update.log 2>&1
			echo "...installing chefdk"
|
		ws_c7.vm.provision "chef_zero" do |chef|
			chef.node_name = 'ws-c7'
			chef.product = 'chefdk'
			chef.channel = 'current'
			chef.version = '4.3.13'
			chef.install = false
			chef.cookbooks_path = "cookbooks"
			chef.data_bags_path = "data_bags"
			chef.nodes_path = "nodes"
			chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

# note: dpkg writes it's crap to stderr, so the 1>&2 is reversed
# dpkg cannot be made to install silently...it's uses mmap
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=288778 (11years old!)

	config.vm.define "ws_u16" do |ws_u16|
		ws_u16.vm.box = "ubuntu/xenial64"
		ws_u16.vm.network 'private_network', ip: '192.168.10.116'
		ws_u16.vm.hostname = 'ws-u16'

		ws_u16.vm.provision "shell", inline: %q|
			apt-get update -y
			echo "...installing chefdk..."
|
		ws_u16.vm.provision "chef_zero" do |chef|
			chef.node_name = 'ws-u16'
			chef.product = 'chefdk'
			chef.channel = 'current'
			chef.version = '4.3.13'
			chef.install = false
			chef.cookbooks_path = "cookbooks"
			chef.data_bags_path = "data_bags"
			chef.nodes_path = "nodes"
			chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

	config.vm.define "ws_u18" do |ws_u18|
		ws_u18.vm.box = "ubuntu/bionic64"
		ws_u18.vm.network 'private_network', ip: '192.168.10.118'
		ws_u18.vm.hostname = 'ws-u18'

		ws_u18.vm.provision "shell", inline: %q|
			apt-get update -y
			echo "......installing chefdk..."
|
		ws_u18.vm.provision "chef_zero" do |chef|
			chef.node_name = 'ws-u16'
			chef.product = 'chefdk'
			chef.channel = 'current'
			chef.version = '4.3.13'
			chef.install = false
			chef.cookbooks_path = "cookbooks"
			chef.data_bags_path = "data_bags"
			chef.nodes_path = "nodes"
			chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

##-------------------------------------------------------------------------------
# configure chef nodes
# https://downloads.chef.io/chef/15.2.20
##-------------------------------------------------------------------------------

	config.vm.define "node_c6" do |node_c6|
		node_c6.vm.box = "geerlingguy/centos6"
		node_c6.vm.network 'private_network', ip: '192.168.10.206'
		node_c6.vm.hostname = 'node-c6'
		node_c6.vm.provision "shell", inline: %q|
			# yum update -y
|
		node_c6.vm.provision "chef_zero" do |chef|
			chef.node_name = 'node-c6'
			chef.install = false
			chef.product = 'chef'
			chef.channel = 'stable'
			# chef.version = '14.13.11'
			chef.cookbooks_path = "cookbooks"
			chef.data_bags_path = "data_bags"
			chef.nodes_path = "nodes"
			chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

	config.vm.define "node_c7" do |node_c7|
		node_c7.vm.box = "geerlingguy/centos7"
		node_c7.vm.network 'private_network', ip: '192.168.10.207'
		node_c7.vm.hostname = 'node-c7'
		node_c7.vm.provision "shell", inline: %q|
			# yum update -y
|
		node_c7.vm.provision "chef_zero" do |chef|
			chef.node_name = 'node-c7'
			chef.install = false
			chef.product = 'chef'
			chef.channel = 'stable'
			# chef.version = '14.13.11'
			chef.cookbooks_path = "cookbooks"
			chef.data_bags_path = "data_bags"
			chef.nodes_path = "nodes"
			chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

	config.vm.define "node_u16" do |node_u16|
		node_u16.vm.box = "ubuntu/xenial64"
		node_u16.vm.network 'private_network', ip: '192.168.10.216'
		node_u16.vm.hostname = 'node-u16'
		node_u16.vm.provision "shell", inline: %q|
			apt-get update -y
|
		node_u16.vm.provision "chef_zero" do |chef|
			chef.node_name = 'node-u16'
			chef.install = false
			chef.product = 'chef'
			chef.channel = 'stable'
			# chef.version = '14.13.11'
			chef.cookbooks_path = "cookbooks"
			chef.data_bags_path = "data_bags"
			chef.nodes_path = "nodes"
			chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

	config.vm.define "node_u18" do |node_u18|
		node_u18.vm.box = "ubuntu/bionic64"
		node_u18.vm.network 'private_network', ip: '192.168.10.218'
		node_u18.vm.hostname = 'node-u18'
		node_u18.vm.provision "shell", inline: %q|
			apt-get update -y
|
					node_u18.vm.provision "chef_zero" do |chef|
			chef.node_name = 'node-u18'
			chef.install = false
			chef.product = 'chef'
			chef.channel = 'stable'
			# chef.version = '14.13.11'
			chef.cookbooks_path = "cookbooks"
			chef.data_bags_path = "data_bags"
			chef.nodes_path = "nodes"
			chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

end
