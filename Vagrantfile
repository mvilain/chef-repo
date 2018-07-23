# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Vagrantfile for chef-rep (creates workstation VM plus a bunch of clients)

Vagrant.configure("2") do |config|
	# config.vm.network 'forwarded_port', guest: 80, host: 8080
	config.ssh.insert_key = true
	config.vm.synced_folder '.', '/vagrant', disabled: false
	config.vm.provider :virtualbox do |vb|
		#vb.gui = true
		vb.memory = '1024'
	end

	#
	# PROVISION ON ALL MACHINES 
	# -- allow ssh w/o checking
	# -- display 2nd interface (Fedora 21 didn't like 2nd interface and needed fixing)
	#
	config.vm.provision "shell", inline: <<-SHELLALL
		echo "...disabling ssh CheckHostIP..."
		sed -i.orig -e "s/#   CheckHostIP yes/CheckHostIP no/" /etc/ssh/ssh_config
		# for i in /etc/sysconfig/network-scripts/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-enp0s8; do
		# 	if [ -e ${i} ]; then echo "...displaying ${i}..."; cat ${i}; fi
		# done

		# echo "...`date` installing chef..."
		# curl -L https://omnitruck.chef.io/install.sh >chef-install.sh 2>&1
		# bash ./chef-install.sh -v 13.8.5 >chef-install.log 2>&1
		# cat chef-install.log
	SHELLALL

##-------------------------------------------------------------------------------
# configure a Chef Workstation (RHEL 6+7, SuSE 11+12, Ubuntu 14.04+16.04+18.04)
# https://docs.chef.io/platforms.html
##-------------------------------------------------------------------------------

	config.vm.define "ws_c6" do |ws_c6|
		ws_c6.vm.box = "geerlingguy/centos6"
		ws_c6.vm.network 'private_network', ip: '192.168.10.106'
		ws_c6.vm.hostname = 'ws-c6'
		
		ws_c6.vm.provision "shell", inline: <<-SHELL
			# echo "...`date` yum update (this may take a few moments)..."
			# yum update -y >yum-update.log 2>&1
			echo "...`date` installing chefdk..."
			yum install -y https://packages.chef.io/files/stable/chefdk/2.5.3/el/6/chefdk-2.5.3-1.el6.x86_64.rpm
		SHELL
		ws_c6.vm.provision "chef_zero" do |chef|
			chef.node_name = 'ws-c6'
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

		ws_c7.vm.provision "shell", inline: <<-SHELL
			# echo "...yum update (this may take a few moments)..."
			# yum update -y >yum-update.log 2>&1
			echo "...`date` installing chefdk..."
			yum install -y https://packages.chef.io/files/stable/chefdk/2.5.3/el/7/chefdk-2.5.3-1.el7.x86_64.rpm
		SHELL
		ws_c7.vm.provision "chef_zero" do |chef|
			chef.node_name = 'ws-c7'
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
	config.vm.define "ws_u14" do |ws_u14|
		ws_u14.vm.box = "geerlingguy/ubuntu1404"
		ws_u14.vm.network 'private_network', ip: '192.168.10.114'
		ws_u14.vm.hostname = 'ws-u14'

# dpkg cannot be made to install silently...it's uses mmap
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=288778 (11years old!)
		ws_u14.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			echo "...`date` downloading chefdk..."
			wget https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/14.04/chefdk_2.5.3-1_amd64.deb
			echo "...`date` installing chefdk..."
			dpkg -i chefdk_2.5.3-1_amd64.deb
		SHELL
		ws_u14.vm.provision "chef_zero" do |chef|
			chef.node_name = 'ws-u14'
			chef.install = false

			chef.cookbooks_path = "cookbooks"
		    chef.data_bags_path = "data_bags"
		    chef.nodes_path = "nodes"
		    chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

	config.vm.define "ws_u16" do |ws_u16|
		ws_u16.vm.box = "geerlingguy/ubuntu1604"
		ws_u16.vm.network 'private_network', ip: '192.168.10.116'
		ws_u16.vm.hostname = 'ws-u16'

		ws_u16.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
			echo "...`date` downloading chefdk..."
			wget https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb
			echo "...`date` installing chefdk..."
			dpkg -i chefdk_2.5.3-1_amd64.deb
		SHELL
		ws_u16.vm.provision "chef_zero" do |chef|
			chef.node_name = 'ws-u16'
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
##-------------------------------------------------------------------------------
	config.vm.define "node_c6" do |node_c6|
		node_c6.vm.box = "geerlingguy/centos6"
		node_c6.vm.network 'private_network', ip: '192.168.10.206'
		node_c6.vm.hostname = 'node-c6'
		
		node_c6.vm.provision "shell", inline: <<-SHELL
			# yum update -y
		SHELL
		node_c6.vm.provision "chef_zero" do |chef|
			chef.node_name = 'node-c6'
			chef.product = 'chef'
			chef.channel = 'stable'
			chef.version = '13.8.5'

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

		node_c7.vm.provision "shell", inline: <<-SHELL
			# yum update -y
		SHELL
		node_c7.vm.provision "chef_zero" do |chef|
			chef.node_name = 'node-c7'
			chef.product = 'chef'
			chef.channel = 'stable'
			chef.version = '13.8.5'

			chef.cookbooks_path = "cookbooks"
		    chef.data_bags_path = "data_bags"
		    chef.nodes_path = "nodes"
		    chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

	config.vm.define "node_u14" do |node_u14|
		node_u14.vm.box = "geerlingguy/ubuntu1404"
		node_u14.vm.network 'private_network', ip: '192.168.10.214'
		node_u14.vm.hostname = 'node-u14'

		node_u14.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
		SHELL
		node_u14.vm.provision "chef_zero" do |chef|
			chef.node_name = 'node-u14'
			chef.product = 'chef'
			chef.channel = 'stable'
			chef.version = '13.8.5'

			chef.cookbooks_path = "cookbooks"
		    chef.data_bags_path = "data_bags"
		    chef.nodes_path = "nodes"
		    chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

	config.vm.define "node_u16" do |node_u16|
		node_u16.vm.box = "geerlingguy/ubuntu1604"
		node_u16.vm.network 'private_network', ip: '192.168.10.216'
		node_u16.vm.hostname = 'node-u16'

		node_u16.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
		SHELL
		node_u16.vm.provision "chef_zero" do |chef|
			chef.node_name = 'node-u16'
			chef.product = 'chef'
			chef.channel = 'stable'
			chef.version = '13.8.5'

			chef.cookbooks_path = "cookbooks"
		    chef.data_bags_path = "data_bags"
		    chef.nodes_path = "nodes"
		    chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end


	config.vm.define "node_u18" do |node_u18|
		node_u18.vm.box = "geerlingguy/ubuntu1804"
		node_u18.vm.network 'private_network', ip: '192.168.10.218'
		node_u18.vm.hostname = 'node-u18'

		node_u18.vm.provision "shell", inline: <<-SHELL
			apt-get update -y
		SHELL
		node_u18.vm.provision "chef_zero" do |chef|
			chef.node_name = 'node-u18'
			chef.product = 'chef'
			chef.channel = 'stable'
			chef.version = '13.8.5'

			chef.cookbooks_path = "cookbooks"
		    chef.data_bags_path = "data_bags"
		    chef.nodes_path = "nodes"
		    chef.roles_path = "roles"
			# chef.add_role "common_role"
			# chef.arguments = [""]
		end
	end

end
