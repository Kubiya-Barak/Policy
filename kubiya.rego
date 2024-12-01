package kubiya.tool_manager

# Default deny all access
default allow = false

# List of admin-only Okta functions
admin_only_functions = {
   "get_user",
   "search_users",
   "list_users",
   "list_groups",
   "create_group",
   "update_group",
   "delete_group",
   "get_group",
   "list_members",
   "add_member",
   "remove_member"
}

# Nobody can run this tool except with special permission
restricted_tool = "jit_session_grant_database_access_to_staging"

# Allow Administrators to run everything except the restricted tool
allow {
   group := input.user.groups[_]
   group == "Administrator"
   input.tool.name != restricted_tool
}

# Allow everyone to run everything except admin functions and restricted tool
allow {
   input.tool.name != restricted_tool
   not admin_only_functions[input.tool.name]
}
