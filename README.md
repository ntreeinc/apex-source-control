# apex-source-control
Scripts for bringing Oracle Application Express applications into version control, any version control tool may be used. Scripts designed to work for Linux and OSX (Will not work on Windows). These scripts were designed using this paper as reference:
http://www.rwijk.nl/AboutOracle/psdua.pdf
. If you have questions about workflow or any other concepts you should look there before posting.
## Setup
#### Required files and environment variables

#### Setting up required scripts

#### Grabbing the export file

#### Splitting the export file

#### Importing into Apex

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
