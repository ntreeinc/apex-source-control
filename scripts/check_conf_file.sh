#!/bin/bash
#
# This script is designed to be run from the top level directory of your project and will break if called from anywhere else

if [ ! -h ./config/apexupdate.conf ]; then
   echo "Missing symbolic link: $PWD/config/apexupdate.conf"
   echo "Please use the command 'npm run switch-conf-file' to create the symbolic link ./config/apexupdate.conf to your config file"
   echo "If you don't have a config file set up you can create one using 'make new-config-file'"
   exit 1
fi

echo "Using the config file at: $(readlink config/apexupdate.conf)"

source ./config/apexupdate.conf

if [ -z "$apexappid" ]; then
   echo "Missing config: $apexappid apexappid"; exit 1
fi

if [ -z "$workspace_name" ]; then
   echo "Missing config: $workspace_name workspace_name"; exit 1
fi

if [ -z "$database_connection" ]; then
   echo "Missing config: $database_connection database_connection"; exit 1
fi

if [ -z "$username" ]; then
   echo "Missing config: $username username"; exit 1
fi

if [ -z "$password" ]; then
   echo "Missing config: $password password"; exit 1
fi

echo "Config file looks good! Moving on to the next step..."
