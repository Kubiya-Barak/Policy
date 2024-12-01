package kubiya.tool_manager

# Default deny all access
default allow = false

# List of admin-only Okta functions
admin_only_functions = {
   "functions.get_user",
   "functions.search_users",
   "functions.list_users",
   "functions.list_groups",
   "functions.create_group",
   "functions.update_group",
   "functions.delete_group",
   "functions.get_group",
   "functions.list_members",
   "functions.add_member",
   "functions.remove_member"
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
