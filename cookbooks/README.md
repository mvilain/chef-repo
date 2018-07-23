# Using cookbooks

This directory contains the cookbooks used to configure systems in your infrastructure with Chef.

Knife needs to be configured to know where the cookbooks are located with the `cookbook_path` setting. If this is not set, then several cookbook operations will fail to work properly.

    cookbook_path ["./cookbooks"]

This setting tells knife to look for the cookbooks directory in the present working directory. This means the knife cookbook subcommands need to be run in the `chef-repo` directory itself. To make sure that the cookbooks can be found elsewhere inside the repository, use an absolute path. This is a Ruby file, so something like the following can be used:

    current_dir = File.dirname(__FILE__)
    cookbook_path ["#{current_dir}/../cookbooks"]

Which will set `current_dir` to the location of the knife.rb file itself (e.g. `~/chef-repo/.chef/knife.rb`).

Configure knife to use your preferred copyright holder, email contact and license. Add the following lines to `.chef/knife.rb`.

    cookbook_copyright "Example, Com."
    cookbook_email     "cookbooks@example.com"
    cookbook_license   "apachev2"

Supported values for `cookbook_license` are "apachev2", "mit","gplv2","gplv3",  or "none". These settings are used to prefill comments in the default recipe, and the corresponding values in the metadata.rb. You are free to change the the comments in those files.

# Creating new Cookbooks

Create new cookbooks in this directory with Knife.

    knife cookbook create COOKBOOK

This will create all the cookbook directory components. You don't need to use them all, and can delete the ones you don't need. It also creates a README file, metadata.rb and default recipe.

You can also download cookbooks directly from the Opscode Cookbook Site. There are two subcommands to help with this depending on what your preference is.

The first and recommended method is to use a vendor branch if you're using Git. This is automatically handled with Knife.

# Installing Cookbooks to chef server

    knife cookbook site install COOKBOOK

This will:

* Download the cookbook tarball from cookbooks.opscode.com.
* Ensure its on the git master branch.
* Checks for an existing vendor branch, and creates if it doesn't.
* Checks out the vendor branch (chef-vendor-COOKBOOK).
* Removes the existing (old) version.
* Untars the cookbook tarball it downloaded in the first step.
* Adds the cookbook files to the git index and commits.
* Creates a tag for the version downloaded.
* Checks out the master branch again.
* Merges the cookbook into master.
* Repeats the above for all the cookbooks dependencies, downloading them from the community site

The last step will ensure that any local changes or modifications you have made to the cookbook are preserved, so you can keep your changes through upstream updates.

If you're not using Git, use the site download subcommand to download the tarball.

    knife cookbook site download COOKBOOK

This creates the COOKBOOK.tar.gz from in the current directory (e.g., `~/chef-repo`). We recommend following a workflow similar to the above for your version control tool.

# Site-specific Cookbooks and roles

- common_recipes

  This cookbook installs and configures applications and services common to all machines. It is used by the role **common_role**

- phpapp

  This cookbook and role are used to create a vanilla Wordpress site on the local machine.

- starter

  This cookbook is used by the **starter** role as an example

# List of Supermarket cookbooks 

This repo makes use of many community-written cookbooks and recipes.  Here's a list

- apache2
- aws
- chef-sugar
- homebrew 
- iis 
- iptables
- logrotate
- mariadb (includes apt, build-essential, seven-zip, windows, mingw, selinux_policy, yum, yum-epel, yum-scl, inifile_chef_gem)
- mysql (includes mysql2_chef_gem, build-essential, seven-zip, windows, mingw, mariadb)
- ntp
- pacman 
- php (includes build-essential, seven-zip, windows, mingw, seven-zip, yum-epel)
- postgresql (includes build-essential, seven-zip, windows, openssl)

Update these cookbooks with the following command:

```bash
knife cookbook site install apache2
knife cookbook site install aws
knife cookbook site install chef-sugar
knife cookbook site install homebrew 
knife cookbook site install iis
knife cookbook site install iptables
knife cookbook site install logrotate
knife cookbook site install mariadb
knife cookbook site install mysql
knife cookbook site install ntp
knife cookbook site install pacman 
knife cookbook site install php
knife cookbook site install postgresql
```
