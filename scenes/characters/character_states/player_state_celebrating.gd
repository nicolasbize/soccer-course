class_name PlayerStateCelebrating
extends PlayerState

const AIR_FRICTION := 35.0
const CELEBRATING_HEIGHT := 2.0

func _enter_tree() -> void:
	celebrate()

func _process(delta: float) -> void:
	if player.height == 0:
		celebrate()
	player.velocity = player.velocity.move_toward(Vector2.ZERO, delta * AIR_FRICTION)

func celebrate() -> void:
	animation_player.play("celebrate")
	player.height = 0.1
	player.height_velocity = CELEBRATING_HEIGHT
