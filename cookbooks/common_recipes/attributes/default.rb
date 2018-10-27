# This is a Chef attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

# For further information, see the Chef documentation (https://docs.chef.io/essentials_cookbook_attribute_files.html).

# case node['platform_family']
# when 'debian'
#   # do things on debian-ish platforms (debian, ubuntu, linuxmint)
# when 'rhel'
#   # do things on RHEL platforms (redhat, centos, scientific, etc)
# end
# if %w(debian ubuntu).include?(node['platform'])
#   # do debian/ubuntu things with the Ruby array %w() shortcut
# end
# 
# if %w(redhat centos fedora).include?(node['platform'])
#   # do debian/ubuntu things with the Ruby array %w() shortcut
# end


case node['platform']
when 'debian'
	default["common_packages"] = [
		'git', 
		'lsof',
		'make',
		'moreutils', 
		'net-tools',
		'ntp', 
		'vim',
		'ntpdate'
		]
	default["ntp_host"] = "0.debian.ntp.org"
	default["ntp_service"] = "ntp"

when 'ubuntu'
	default["common_packages"] = [
		'git', 
		'lsof',
		'make',
		'moreutils', 
		'net-tools',
		'ntp', 
		'vim',
		'iproute'
		]
	default["ntp_host"] = "0.ubuntu.pool.ntp.org"
	default["ntp_service"] = "ntpd"

when 'redhat'
	default["common_packages"] = [
		'git', 
		'lsof',
		'make',
		'moreutils', 
		'net-tools',
		'ntp', 
		'vim',
		'iproute',
		'yum-epel'
		]
	default["ntp_host"] = "0.redhat.pool.ntp.org"
	default["ntp_service"] = "ntpd"

when 'centos'
	default["common_packages"] = [
		'git', 
		'lsof',
		'make',
		'moreutils', 
		'net-tools',
		'ntp', 
		'vim',
		'epel-release',
		'iproute',
		'yum-epel'
		]
	default["ntp_host"] = "0.centos.pool.ntp.org"
	default["ntp_service"] = "ntpd"

when 'fedora'
	default["common_packages"] = [
		'git', 
		'lsof',
		'make',
		'moreutils', 
		'net-tools',
		'ntp', 
		'vim',
		'iproute',
		'yum-epel'
		]
	default["ntp_host"] = "0.fedora.ntp.org"
	default["ntp_service"] = "ntpd"


else # everything else
	default["common_packages"] = [
		'git', 
		'lsof',
		'make',
		'moreutils', 
		'net-tools',
		'ntp', 
		'vim'
		]
	default["ntp_host"] = "0.north-america.pool.ntp.org"
	default["ntp_service"] = "ntpd"

end

default["timezone"] = "America/Los_Angeles"
