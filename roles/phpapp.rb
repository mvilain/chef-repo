name "phpapp"
description "role for the phpapp recipe to create a php-based application"
run_list "recipe[apt]", "recipe[phpapp]"
default_attributes "phpapp" => [ "db_password": "212b09752d173876a84d374333ae1ffe" ]
