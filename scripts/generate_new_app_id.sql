--spool config/new_app_id.txt
set serveroutput on
set feedback off
begin
   apex_application_install.generate_application_id;
   dbms_output.put_Line("Your new apex app id is..."); --This line should be commented out if you want to use spooling
   dbms_output.put_Line(apex_application_install.get_application_id);
end;
/
--spool off
exit
