# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    autoIndex.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tludwig <tludwig@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/20 01:29:56 by tludwig           #+#    #+#              #
#    Updated: 2020/08/20 01:37:54 by tludwig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

if grep -q "autoindex on" /etc/nginx/sites-available/myProj.conf
then
    sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-available/myProj.conf
    echo "autoindex disabled"
elif grep -q "autoindex off" /etc/nginx/sites-available/myProj.conf
then
    sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-available/myProj.conf
    echo "autoindex enabled"
else echo 'Something went wrong'
fi

service nginx restart;