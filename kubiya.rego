package kubiya.tool_manager

# Default deny all access

default allow = false

# Define prefixes for admin-only and restricted functions
admin_only_prefixes = {
   "s3_revoke_",
   "jit_session_revoke_"
}

restricted_prefixes = {
   "s3_grant_",
   "jit_session_grant_"
}

# Non-dynamic admin functions
admin_only_functions = {
   "list_active_access_requests", 
   "search_access_requests", 
   "approve_tool_access_request"
}

# Check if tool name starts with any restricted prefix

is_restricted_tool {
   some prefix in restricted_prefixes
   startswith(input.tool.name, prefix)
}

# Check if tool name starts with any admin-only prefix

is_admin_tool {
   some prefix in admin_only_prefixes
   startswith(input.tool.name, prefix)
}

# List of restricted tools (nobody can run these)
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

# Allow Administrators to run admin-only tools
allow {
   group := input.user.groups[_].name
   group == "test"
   is_admin_tool
}

# Allow Administrators to run specific admin functions

allow {
   group := input.user.groups[_].name
   group == "test"
   admin_only_functions[input.tool.name]
}

# Allow everyone to run everything except admin functions and restricted tools
allow {
   not is_restricted_tool
   not is_admin_tool
   not admin_only_functions[input.tool.name]
   not restricted_tools[input.tool.name]
}
