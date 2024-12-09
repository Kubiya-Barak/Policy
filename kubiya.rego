package kubiya.tool_manager

# Default deny all access
default allow = false

# List of admin-only functions and tools
admin_tools = {
    "list_active_access_requests", 
    "search_access_requests", 
    "approve_tool_access_request",
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

# Nobody (including admins) can run these
restricted_prefixes = {
    "s3_grant_",
    "jit_session_grant_"
}

# Only admins can run these
admin_prefixes = {
    "s3_revoke_",
    "jit_session_revoke_"
}

# Allow Administrators to run admin tools
allow {
    group := input.user.groups[_].name
    group == "Admin"
    admin_tools[input.tool.name]
}

# Allow Administrators to run revoke tools (s3_revoke_*, jit_session_revoke_*)
allow {
    group := input.user.groups[_].name
    group == "Admin"
    startswith(input.tool.name, admin_prefixes[_])
}

# Allow everyone to run everything except:
# - admin tools
# - grant/revoke prefixed tools
allow {
    not admin_tools[input.tool.name]
    not startswith(input.tool.name, restricted_prefixes[_])
    not startswith(input.tool.name, admin_prefixes[_])
}
