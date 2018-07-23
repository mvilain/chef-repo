name               "common_role"
description        "role for all the nodes installing default packages and services"
run_list           "recipe[ntp]", "recipe[common_recipes]"

