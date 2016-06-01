# designed to be called from to level project dir

if [ ! -h ./config/apexupdate.conf ]; then
   echo "Missing symbolic link: $PWD/config/apexupdate.conf"
   echo "Please use the command 'npm run switch-conf-file' to create the symbolic link ./config/apexupdate.conf to your config file"
   echo "If you don't have a config file set up you can create one using 'npm run new-config-file'"
   exit 1
fi

echo "The config file currently being used is: "
readlink ./config/apexupdate.conf

echo

echo "The config file looks like this: "
cat ./config/apexupdate.conf

echo "If any of the data looks wrong you can simply edit the file yourself at ./config/$(readlink ./config/apexupdate.conf)"
