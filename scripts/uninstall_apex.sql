declare
  p_application_id    NUMBER := '&1';
  p_workspace_name    varchar2(255) := '&2';
  p_parsing_schema    varchar2(255) := '&3';
  l_workspace_id      NUMBER;
begin
  apex_application_install.set_application_id ( p_application_id );
  l_workspace_id := apex_util.find_security_group_id (p_workspace => p_workspace_name ); 
  apex_application_install.set_schema( p_parsing_schema );
  APEX_APPLICATION_INSTALL.SET_WORKSPACE_ID ( l_workspace_id );
end;
/
@../../apex/application/init.sql
@../../apex/application/set_environment.sql
@../../apex/application/delete_application.sql
@../../apex/application/end_environment.sql
/
quit
