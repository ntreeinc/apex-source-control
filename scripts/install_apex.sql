declare
  p_application_id    NUMBER := '&1';
  p_workspace_name    varchar2(255) := '&2';
  p_parsing_schema    varchar2(255) := '&3';
  l_workspace_id      NUMBER;
begin
  apex_application_install.set_application_id ( p_application_id );
  apex_application_install.set_schema( p_parsing_schema );
  apex_application_install.set_application_alias( 'F' || p_application_id );
  l_workspace_id := apex_util.find_security_group_id (p_workspace => p_workspace_name);
  APEX_APPLICATION_INSTALL.SET_WORKSPACE_ID ( l_workspace_id );
  --apex_application_install.set_offset( p_offset_num );
  apex_application_install.generate_offset;
end;
/
@install_apex_components
/
quit
