class_name AIBehaviorFactory

var roles : Dictionary

func _init() -> void:
	roles = {
		Player.Role.DEFENSE: AIBehaviorField,
		Player.Role.GOALIE: AIBehaviorGoalie,
		Player.Role.MIDFIELD: AIBehaviorField,
		Player.Role.OFFENSE: AIBehaviorField,
	}

func get_ai_behavior(role: Player.Role) -> AIBehavior:
	assert(roles.has(role), "role doesn't exist!")
	return roles.get(role).new()
