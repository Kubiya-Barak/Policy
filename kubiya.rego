package kubiya.tool_manager

default allow = false


allow {
    group = input.user.groups[_]
    group == "Kubiya R&D"
    tool != "cluster_health"
}

allow {
    group = input.user.groups[_]
    group == "Administrators"
    tool != "cluster_health"    
}

allow {
    tool = input.tool.name
    tool == "request_tool_access"
}

allow {
    tool = input.tool.name
    email = input.user.email
    tool == "cluster_health"
    email == "amit@kubiya.ai"
}

allow {
    tool = input.tool.name
	group = input.user.groups[_]
    namespace = input.tool.parameters.namespace

    namespace == "all - typo"
    group == "Kubiya R&D - typo"
    tool == "pod_disruption_budget_checker"
}

allow {
    tool = input.tool.name
    email = input.user.email
    namespace = input.tool.parameters.namespace

    namespace == "all - typo"
    email == "kris.talajic@kubiya.ai - typo"
    tool == "pod_disruption_budget_checker - typo"
}
