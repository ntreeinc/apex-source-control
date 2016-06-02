# apex-source-control
Scripts for bringing Oracle Application Express applications into version control, any version control tool may be used.
Scripts are designed to work with Linux and OSX (Will not work on Windows).
These scripts were designed using [this paper] (http://www.rwijk.nl/AboutOracle/psdua.pdf) as reference.
If you have questions about workflow or any other concepts you should look for answers there first.
## Setup
#### Required files and environment variables
For these scripts to work you need the APEXExport.class and APEXExportSplitter.class which come with [APEX] (http://www.oracle.com/technetwork/developer-tools/apex/downloads/index.html) as well as [ojdbc6.jar] (http://www.oracle.com/technetwork/apps-tech/jdbc-112010-090769.html) which comes with Oracle database.
Note: you don't need to have oracle or apex installed locally, you just need the aforementioned files and a particular directory structure.

If you've extracted APEX then you need to set the APEX_HOME variable using:

	export APEX_HOME=/path/to/apex

where path/to/apex is the directory where you extracted APEX. You'll probably want to add this to your bash profile.

The scripts will look for the required .class files in $APEX_HOME/utilities/oracle/apex/ so if you're only using the .class files set up the directory structure and APEX_HOME variable accordingly.

If you have a local installation of Oracle database your ORACLE_HOME variable should already be set so just need to ensure that you have the ojdbc6.jar file at $ORACLE_HOME/jdbc/lib/ojdbc6.jar.
Otherwise, if you only have the ojdbc6.jar file, make a directory somewhere, set the relevant environment variable using

	export ORACLE_HOME=/path/to/your/dir

and put ojdbc6.jar at $ORACLE_HOME/jdbc/lib/ojdbc6.jar as mentioned before. Again you'll want to add the above line to your bash profile.

#### Setting up from an APEX export file
Note: If you already have an existing repository for the project you shouldn't use this method of installation, otherwise you may run into excessive version-control noise issues with conflicting object ids . This will likely only work if the the Export with Original IDs option was checked during export.

1) Make a local directory for your application:

	mkdir my-project

2) Run npm init, follow the given prompts and add the following line to your devDependencies in package.json

	"devDependencies": {
	    "apex-source-control" : "git+ssh://git@github.com:ntreeinc/apex-source-control.git"
	},

3) Add the following commands to your scripts in package.json

	"scripts": {
	   "apex-to-file" : "apex-source-control apex-to-file",
	   "file-to-apex" : "apex-source-control file-to-apex",
	   "new-conf-file" : "apex-source-control new-conf-file",
	   "switch-conf-file" : "apex-source-control switch-conf-file",
	   "read-conf-file" : "apex-source-control read-conf-file",
	   "generate-app-id" : "apex-source-control generate-app-id",
	   "uninstall-apex" : "apex-source-control uninstall-apex"
	},
If you want you can change the npm run commands to anything you'd like.

4) cd into node_modules/apex-source-control and run npm install, then link the scripts using the command 'npm link'. You may have to run this command as root.

5) Copy the export file into your project directory

6) Set up your classpath and run APEXExportSplitter

	export CLASSPATH=$APEX_HOME/utilities:$ORACLE_HOME/jdbc/lib/ojdbc6.jar
	java oracle.apex.APEXExportSplitter $export_file

7) Rename the generated directory to apex/

8) cd into apex/ and run:

	sed s^@application^@apex/application^ < install.sql > temp.sql
	rm -f install.sql
	mv temp.sql install.sql

We do this because we need to set the relative path to the install components from the top level directory

From here you can now either set up the project as a git/subversion/etc. repository or install into apex using 'npm run new-conf-file', enter data as needed; 'npm run switch-conf-file', switch to your new config file; and then 'npm run file-to-apex'.

#### Setting up from another APEX app

1) Make a local directory for your application:

	mkdir my-project

2) Run npm init, follow the given prompts and add the following line to your devDependencies in package.json

	"devDependencies": {
	    "apex-source-control" : "git+ssh://git@github.com:ntreeinc/apex-source-control.git"
	},

3) Add the following commands to your scripts in package.json

	"scripts": {
	   "apex-to-file" : "apex-source-control apex-to-file",
	   "file-to-apex" : "apex-source-control file-to-apex",
	   "new-conf-file" : "apex-source-control new-conf-file",
	   "switch-conf-file" : "apex-source-control switch-conf-file",
	   "read-conf-file" : "apex-source-control read-conf-file",
	   "generate-app-id" : "apex-source-control generate-app-id",
	   "uninstall-apex" : "apex-source-control uninstall-apex"
	},
If you want you can change the npm run commands to anything you'd like.

4) cd into node_modules/apex-source-control and run npm install, then link the scripts using the command 'npm link'. You may have to run this command as root.

5) Run the following commands and follow the prompts. The app id, parsing_schema, workspace_name and database connection info should all correspond to the app you want to download.
	
	npm run new-conf-file 		#create a config file with the info of the app you want to download
	npm run switch-conf-file 	#tell scripts to use the config file you just created
	npm run apex-to-file 		#download the app locally

You can now set up the application as a git or other version-control repository.

#### Setting up from a pre-existing repository

1) Clone the repository locally

2) Use 'npm install' to install dependencies

3) Run the following commands and follow the prompts. This will set up your config file and put the application into your APEX workspace

	npm run new-conf-file 		#create config file with the info of the app you want to use for version control
	npm run switch-conf-file 	#tell scripts to use the config file you just created
	npm run file-to-apex 		#download the app locally
That's it!

When you run 'npm run new-conf-file' you can either enter the info of the app you are already using to develop (your version will be overwritten by the one in version control) or enter in the info of a non-existent app which will be automatically created after running 'npm run file-to-apex'


## npm scripts Commands
##### npm run apex-to-file
Turn your apex workspace project into a file directory suitable for version control tools
##### npm run file-to-apex
Import your file directory into apex as an apex application. This command will only work with a $PROJECT_HOME/apex/ dir which was generated by APEXExportSplitter
##### npm run uninstall-apex
Uninstall your app from apex
##### npm run create-new-app
Currently not an availible command, may be added in the future.
##### npm run new-conf-file
Creates a new config file using user input. NOTE: As of right now you must run 'npm run switch-conf-file' command to change to the new config file after creating a new one
##### npm run switch-conf-file
Switches which config file is being used
##### npm run read-conf-file
Outputs the name and contents of the config file currently being used

###Workflow
TODO write workflow section 

###Config File Explained
May later add this section explaining each of the config parameters

###Known Issues
#### Deleting a page will always win merges
**To Reproduce**: 
* Have two developers working on different versions of an app (i.e. working on different features to be added).
* Developer 1 deletes a page in the app and pushes to the project's repo.
* Developer 2 merges developer 1's changes and decides to keep the deleted page in the merge.
* When developer 2 reinstalls the app into apex the page will still be deleted.

**Why it occurs**:

Since a page was deleted, it's removed from the install.sql script generated by apex. When git sees the merge of the two developers, only one has changed the install.sql script so it automatically applies those changes to the merge meaning the page is no longer called during install so it's never created in your apex application.

**How to avoid**:

Be extremely cautious when deleting pages and consult with your teammates first

**How to fix**:

If you do end up accidently deleting a page then you will have to manually re-add the install lines to the install.sql

#### Random version control noise in application meta-data
