# designed to be called from top level project dir
node_modules/apex-source-control/scripts/check_conf_file.sh
source config/apexupdate.conf 
cd apex/ 
sqlplus $username/$password@$database_connection @../node_modules/apex-source-control/scripts/install_apex.sql $apexappid $workspace_name $parsing_schema
