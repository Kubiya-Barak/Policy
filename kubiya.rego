# Default deny all access
default allow = false

# Allow Administrators to run admin_only functions
allow {
    group := input.user.groups[_].name
    group == "approvers"
}
