#!/bin/bash
#
# This script is designed to be called from the top level directory of your project and to be placed in the ./scripts/ directory

echo "The availible config files are:"

ls ./config/ | sed s/apexupdate.conf// | grep -F .conf | sed s/.conf//

cd config

echo -n "Please enter the config file you would like to use: "
read username

conf_file="$username.conf"

if [ ! -e $conf_file ]; then
   echo "Sorry, the file ./scripts/$conf_file does not exist. Either create the file using make new-config-file or choose a pre-existing config file."; exit 1
fi

if [ -e apexupdate.conf ]; then
   rm apexupdate.conf
fi

ln -s $conf_file apexupdate.conf

cd ..

echo "./config/apexupdate.conf now points to ./config/$( readlink ./config/apexupdate.conf )"

echo "The new config file looks like this: "

cat ./config/apexupdate.conf
