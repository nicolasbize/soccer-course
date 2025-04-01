class_name BallStateFreeform
extends BallState

func _enter_tree() -> void:
	player_detection_area.body_entered.connect(on_player_enter.bind())

func on_player_enter(body: Player) -> void:
	ball.carrier = body
	state_transition_requested.emit(Ball.State.CARRIED)
