class_name BallStateFreeform
extends BallState

const BOUNCINESS := 0.8
const FRICTION_AIR := 35.0
const FRICTION_GROUND := 250.0

func _enter_tree() -> void:
	player_detection_area.body_entered.connect(on_player_enter.bind())

func on_player_enter(body: Player) -> void:
	ball.carrier = body
	state_transition_requested.emit(Ball.State.CARRIED)

func _process(delta: float) -> void:
	set_ball_animation_from_velocity()
	var friction := FRICTION_AIR if ball.height > 0 else FRICTION_GROUND
	ball.velocity = ball.velocity.move_toward(Vector2.ZERO, friction * delta)
	process_gravity(delta, BOUNCINESS)
	ball.move_and_collide(ball.velocity * delta)
