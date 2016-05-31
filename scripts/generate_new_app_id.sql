spool ../../scripts/new_app_id.txt
set serveroutput on
set feedback off
begin
   apex_application_install.generate_application_id;
   dbms_output.put_Line(apex_application_install.get_application_id);
end;
/
spool off
exit
