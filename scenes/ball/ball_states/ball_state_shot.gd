class_name BallStateShot
extends BallState

const DURATION_SHOT := 1000
const SHOT_HEIGHT := 5
const SHOT_SPRITE_SCALE := 0.8

var time_since_shot := Time.get_ticks_msec()

func _enter_tree() -> void:
	set_ball_animation_from_velocity()
	sprite.scale.y = SHOT_SPRITE_SCALE
	ball.height = SHOT_HEIGHT
	time_since_shot = Time.get_ticks_msec()

func _process(delta: float) -> void:
	if Time.get_ticks_msec() - time_since_shot > DURATION_SHOT:
		transition_state(Ball.State.FREEFORM)
	else:
		move_and_bounce(delta)

func _exit_tree() -> void:
	sprite.scale.y = 1.0
