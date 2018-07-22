# phpapp Cookbook
===============
Create a local Wordpress instance with a mysql database back-end


Requirements
------------
This will install and configure 

- mysql (either mysql or mariadb) on (Ubuntu or CentOS) localhost.  
- php and the libraries to access mysql/mariadb
- apache2 and modules to use mod_php
- latest release of Wordpress from http://wordpress.org/latest.tar.gz

#### packages
- apache2
- mysql
- php
- mysql2_chef_gem

Attributes
----------

- phpapp::database = "phpapp"
- phpapp::db_username = "phpapp"
- phpapp::path = "/var/www/phpapp"
- phpapp::server_name = "phpapp"

Usage
-----
#### phpapp::default

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[phpapp]"
  ]
}
```

License and Authors
-------------------
Authors: 

http://gettingstartedwithchef.com/introducing-chef-server.html
