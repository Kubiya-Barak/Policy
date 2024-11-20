package kubiya.tool_manager

# Default deny all access
default allow = false

# Allow Kubiya R&D team access to all tools except cluster_health
allow {
    group := input.user.groups[_]
    group == "Kubiya R&D"
    tool := input.tool.name
    tool != "jit_session_grant_database_access_to_staging"
}

# Allow Administrators access to all tools except cluster_health
allow {
    group := input.user.groups[_]
    group == "Administrators"
    tool := input.tool.name
    tool != "jit_session_grant_database_access_to_staging"
}

# Always allow access to request_tool_access
allow {
    input.tool.name == "request_tool_access"
}

# Special access for cluster_health tool
allow {
    input.tool.name == "jit_se_access"
    input.user.email == "amit@kubiya.ai"
}

# PDB checker access for Kubiya R&D team
allow {
    input.tool.name == "pod_disruption_budget_checker"
    group := input.user.groups[_]
    namespace := input.tool.parameters.namespace

    # Fixed typos in group name and namespace
    namespace == "all"
    group == "Kubiya R&D"
}

# PDB checker access for specific user
allow {
    input.tool.name == "pod_disruption_budget_checker"
    input.user.email == "kris.talajic@kubiya.ai"
    input.tool.parameters.namespace == "all"
}

# Helper function to check if tool is restricted
is_restricted(tool) {
    restricted_tools := {"cluster_health"}
    restricted_tools[tool]
}
