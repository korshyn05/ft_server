# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tludwig <tludwig@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/20 01:29:41 by tludwig           #+#    #+#              #
#    Updated: 2020/08/20 01:39:36 by tludwig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

service mysql start && mysql < mysql_setup.sql
service php7.4-fpm start && service nginx start

while true
do
    sleep 5000
done