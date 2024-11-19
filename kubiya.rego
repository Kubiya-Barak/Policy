package kubiya.tool_manager

default allow = false

allow {
    group = input.user.groups[_]
    group == "costa - typo"
}

allow {
    group = input.user.groups[_]
    group == "Kubiya R&D - typo"
}

allow {
    group = input.user.groups[_]
    group == "Administrators - typo"
}

allow {
    tool = input.tool.name
    tool == "request tool access"
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
