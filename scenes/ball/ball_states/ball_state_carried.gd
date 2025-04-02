class_name BallStateCarried
extends BallState

const OFFSET_FROM_PLAYER := Vector2(10, 4)
const DRIBBLE_INTENSITY := 3.0
const DRIBBLE_FREQUENCY := 10.0

var dribble_time := 0.0

func _enter_tree() -> void:
	assert(carrier != null)

func _process(delta: float) -> void:
	var vx := 0.0
	dribble_time += delta
	
	if carrier.velocity.length_squared() > 0:
		if abs(carrier.velocity.normalized().y) != 1: # skip move up or down only
			vx = cos(dribble_time * DRIBBLE_FREQUENCY) * DRIBBLE_INTENSITY
		if carrier.heading.x >= 0:
			animation_player.play("roll")
			animation_player.advance(0)
		elif carrier.heading.x < 0:
			animation_player.play_backwards("roll")
			animation_player.advance(0)
	else:
		animation_player.play("idle")
		
	ball.position = carrier.position + Vector2(vx + carrier.heading.x * OFFSET_FROM_PLAYER.x, OFFSET_FROM_PLAYER.y)
		
