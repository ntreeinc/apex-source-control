#!/bin/bash
#
#Script for automatically exporting the apex application from APEX
#
# This script is designed to be run from the top level directory of your project and will break otherwise

if [ -z "$ORACLE_HOME" ]; then
   echo "Missing environment variable: ORACLE_HOME. Please add the path of your oracle installation to your environment variables under the variable name ORACLE_HOME"; exit 1
fi

if [ -z "$APEX_HOME" ]; then
   echo "Missing environment variable: APEX_HOME. Please add the path of your apex installation to your environment variables under the variable name APEX_HOME. Note: You should be using APEX version 5 or above"; exit 1
fi

if [ ! -e $ORACLE_HOME/jdbc/lib/ojdbc6.jar ]; then
   echo "Missing ojdbc6.jar: please download from oracle and put in $ORACLE_HOME/jdbc/lib directory"; exit 1
fi

if [ ! -e $APEX_HOME/utilities/oracle/apex/APEXExport.class ]; then
   echo "Missing APEXExport class. Please ensure you are using Apex 5 or above and have the APEXExport and APEXExportSplitter classes are in the $APEX_HOME/utilities/oracle/apex/ directory"; exit 1
fi

if [ ! -e $APEX_HOME/utilities/oracle/apex/APEXExportSplitter.class ]; then
   echo "Missing APEXExportSplitter class. Please ensure you are using Apex 5 or above and have the APEXExport and APEXExportSplitter classes are in the $APEX_HOME/utilities/oracle/apex/ directory"; exit 1
fi

source ./config/asc.conf

export CLASSPATH=$APEX_HOME/utilities:$ORACLE_HOME/jdbc/lib/ojdbc6.jar

export_file=f$apexappid.sql

if [ -d apex/ ]; then
   rm -r apex/
fi
if [ -e $export_file ]; then
   rm $export_file
fi

java oracle.apex.APEXExport -db $database_connection -user $username -password $password -applicationid $apexappid -skipExportDate -expOriginalIds #

if [ ! 0 -eq $? ]; then
    echo "Exit code #: $?. An error has occured while trying to use APEXExport. Please check that your database_connection, username, password, and apexappid variables are all set correctly."; exit 1
fi

java oracle.apex.APEXExportSplitter $export_file

if [ ! 0 -eq $? ]; then
    echo "Exit code #: $?. An error has occured while trying to use APEXExportSplitter. Please check that your apexappid variable is set correctly and that the application exists in the workspace you are trying to export from"; exit 1
fi

rm $export_file

mv f$apexappid apex #

cd apex/

sed s^@application^@apex/application^ < install.sql > temp.sql
rm -f install.sql
mv temp.sql install.sql

#now you can update your working copy with changes from your colleagues and reinstall into apex
