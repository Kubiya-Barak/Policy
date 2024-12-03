package kubiya.tool_manager

# Default deny all access
default allow = false

# List of admin-only Okta functions
admin_only_functions = {
   view_user_requests,
   list_active_access_requests,
   search_access_requests,
   approve_tool_access_request
}

restricted_tools = {
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

# Allow Administrators to run everything except the restricted tool
allow {
   group := input.user.groups[_].name
   group == "Administrators"
   not restricted_tools[input.tool.name]
}

