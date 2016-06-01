# APEX_test_application
Testing version control for apex apps

## Setup
ensure apex is installed at /usr/local/apex
Ensure you have ojdbc6.jar at $ORACLE_HOME/jdbc/lib
clone the project
Create an empty app in apex to get an app id create a config file in ./scripts

##TODO remove all make references in the project
## Makefile Commands
##### make help
Display this help text
##### make todo
Show all lines which contain TODO in the project
##### make apex-to-file
Turn your apex workspace project into a file directory suitable for version control tools
##### make file-to-apex
Import your file directory into apex as an apex application
##### make uninstall-apex
Uninstall your app from apex
##### make create-new-app
Used for creating an entirely new instance of the app, should only be used when creating a new app instance for a new team member or for reinstalling the app
##### make new-config-file
Creates a new config file
##### make switch-config-file
Switches which config file is being used
##### make which-config-file
Outputs the name of the config file currently being used
